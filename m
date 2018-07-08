Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EBBC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EAB208D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajM0HeX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EAB208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932121AbeGHQSz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 12:18:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33741 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbeGHQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 12:18:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so9042077wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kpgLZhcBpxlSgKDkqcuYLr+S8/VrCC5zloqZffh4yXE=;
        b=ajM0HeX6zPr9xzY9/nv/+3Y2R/UDHvhlm3Pj9icnvsz0xkGM8LbfVDkOCS7TA+G8Ds
         O0Gdi/HF2bqM5InGj+J7HgGM1+Mz59M7+Fwp0S9Pd/kkQav5kD28f/pdBRwMZwUwbi8w
         M2u8KFChZZBeyUrZ4A5gYN/Tct5+OwhUAM+7CXEGplqDWr6L4jRDYVnusImcr9gItftJ
         RmoCRFG1NshV2qi6jA2AxOy5kv7aq99crEN3Tpv7BPUIwNwoqdywpRuhNOXZ0z+px9zu
         m8Pc7ogKIG0OC62KVNozQ9vNmOOFTVTXmpl+XT14GkhADxC+/cBh8GrWCo8JNAdtP8JH
         qQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kpgLZhcBpxlSgKDkqcuYLr+S8/VrCC5zloqZffh4yXE=;
        b=j9+M27joMGV0SXERBDDrysm6np9TrABbOvCzlvDUINIXzuTULcVVmavp3fDQE6pes4
         YCE+dKRnntlAJ0K+NH43zSqcpVNzi134G6X9lw8cnf12H56D9413slaS2Dk6sydcwOG/
         F/I+N2IaulrxQwnAiII6J8pTtN8vWDkbZDMqz0O/S4Y0XI+sZw7qplFo670wQOuL/vqs
         D/r1U9EKAQJHv0HXUACvfmlN3UmTDPPvLXASmR5g4WtDRLtt3mxfpKFNowNFgWnw+mTx
         pyWg7mkTdEz/0fvNY7Zx60RItXncsdYD5w5uYd/fL3L9pglzGkmJud93ol7PQ3XPVo7R
         W2Dw==
X-Gm-Message-State: APt69E2Tqr9YrRU3VROES+T1Le4M1HVQQc6qE6FM82NcJBo47FY0r15+
        R7llRN6SBcV/f8F/ctLsU2w=
X-Google-Smtp-Source: AAOMgpeD3Id6Izbvl7eagYN0hIAXImNEPdU5YzpmNtgcg+s0iLE/h7NMBRiQqD0l3XqRbNTIOKzHig==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13-v6mr11155154wmh.73.1531066733113;
        Sun, 08 Jul 2018 09:18:53 -0700 (PDT)
Received: from xux707-tw (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f190-v6sm27654985wmd.0.2018.07.08.09.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Jul 2018 09:18:52 -0700 (PDT)
Date:   Sun, 8 Jul 2018 17:18:49 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, keescook@chromium.org,
        aastha.gupta4104@gmail.com, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 03/12] staging:rtl8192u: Remove blank lines before '}'
 and after '{' characters
Message-ID: <20180708161847.6rhabjz3belpi63g@xux707-tw>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
 <20180707145513.15325-3-johnfwhitmore@gmail.com>
 <20180708153811.GA29737@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180708153811.GA29737@kroah.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 05:38:11PM +0200, Greg KH wrote:
> On Sat, Jul 07, 2018 at 03:55:04PM +0100, John Whitmore wrote:
> > Coding style change to simply remove the unrequired spaces before a closing
> > brace or before an opening brace.
> 
> That would be good, but that's not what this patch does :(
> 
> It removes lines, not spaces, as the subject line said.  You also fix up
> an indentation as well.
> 
> thanks,
> 
> greg k-h

Oops sorry. I'll fix it up in another pass.
