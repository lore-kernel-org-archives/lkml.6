Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E8CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAD621473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg2a1Pft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAD621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeJDTFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:05:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44695 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeJDTFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:05:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so9634672wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 05:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZMYMit00069q3Wa4pHLtH/qxhEADzGSxQvEGyNiu9lA=;
        b=Qg2a1PftIFC8hU14okQVJawfjzxNxjnkzTsuW+ouU3iwc2tskBDpfQZuqVl57qxX4j
         GThjAIBntybcQVurslTgy/BbIWlUltMxSUpeVG6J5Onf+ATKJ1/bjLo3Yjjn0EYSiW8L
         iFe2REibB55LkiIf2D8Ql9L5lkeDzLWDnPNaP2t7Pmz9kT8daPnRl30J1tRdvFBxbrQM
         4cwv5vp1Qf13XfmDVLkL8EuIdwt7elOEoI8LN922k6rwYXulBcEN1J1CEpUKRUJOsmVT
         QO47JlefiBMMymDq9ggP9rOlOLyNtnHdDNFgTvSDMzk0kNSKOaB6uxgbLvpAw5GvieMf
         8IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZMYMit00069q3Wa4pHLtH/qxhEADzGSxQvEGyNiu9lA=;
        b=EUjBo+qV9WJIglbwrGReQnNinmGt1btCyoSLWj6qwFPKR2zLfPsdU85/FoyPwind17
         bri8Ougf0D+Og8CURJ8NpMgT29RW+gVQhkE3fNYIq84FqJRjKbnRCEOto7gFMoOV3NTx
         qm4+N7JlAN6NVXleiFgcjEy9eEnuKtbSfZ6+6ULUPfiCqYhSvdLSgWISfaWipp7weMed
         Ep5U/FfBfeBwDHJ+tmZlx5xIu5Rpls9UXtm9jP4vMdhZxelbgSa/X4xhj9Oh9vTpU/fV
         mkX+lYfvetZk4sO2bxL6jiAXk3V+BdBDO3pddoL//87z0HKNSRSa+6c/9cw+Re2v9PLz
         2Ykg==
X-Gm-Message-State: ABuFfojaocrTUBUfiWHosjiPEcJm5WwKzcURe6MQK8CBnwjjPbv24iwN
        LjDB2zaESC2uOebXjj5AimusrNUq
X-Google-Smtp-Source: ACcGV62IrrntXCiJmC74GCegfmuhAzzuYMH1eWbE/wxAIZIaD3xDUnawot2mKjBd54TponZnb5B4fw==
X-Received: by 2002:adf:cf0b:: with SMTP id o11-v6mr4543782wrj.272.1538655125190;
        Thu, 04 Oct 2018 05:12:05 -0700 (PDT)
Received: from [192.168.0.19] (ip1f12fa7d.dynamic.kabel-deutschland.de. [31.18.250.125])
        by smtp.gmail.com with ESMTPSA id t143-v6sm4461273wmt.2.2018.10.04.05.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 05:12:04 -0700 (PDT)
Subject: Re: [PATCH 2/3] staging: rtl8188eu: cleanup array declaration - style
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181003204359.30676-1-straube.linux@gmail.com>
 <20181003204359.30676-2-straube.linux@gmail.com>
 <223920513380c40710a833be02d86d8d6258cdab.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <e2c8ffb7-4c62-8da9-9f78-00edb4edcb5e@gmail.com>
Date:   Thu, 4 Oct 2018 14:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <223920513380c40710a833be02d86d8d6258cdab.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/18 11:30 PM, Joe Perches wrote:
   
>>   static struct mlme_handler mlme_sta_tbl[] = {
> 
> Perhaps const here too, and as well, the struct
> declaration could use const char * instead of char *
> 

Making it const gives following warning.

drivers/staging/rtl8188eu/core/rtw_mlme_ext.c: In function 'mgt_dispatcher':
drivers/staging/rtl8188eu/core/rtw_mlme_ext.c:4114:9: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
   ptable = mlme_sta_tbl;
          ^

So I'll only change the char * to const char *.
Thanks.
