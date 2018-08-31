Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A614BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F7F2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0r1cwZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F7F2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeHaRwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:52:30 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:41786 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbeHaRw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:52:29 -0400
Received: by mail-lj1-f171.google.com with SMTP id y17-v6so10133298ljy.8;
        Fri, 31 Aug 2018 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K7F5D6u/WF0ZIAoHKqPGlh7cMjCdFB7jYX+uWCiO63w=;
        b=Y0r1cwZq8gVrF/wG17K6GbEByl1WZ60rVdgf/NCncmPY4efM2T1N1lJUjfCibEPeAG
         nC2JgnDd3k/pBJxYVx595jsiEcTaEzKtuMnARmiWwA4uiF5pH22XHhh5x+6Uy2iEK+dx
         r/6vo7mVmVKIRA46lj/YMIKEb52Dh9T36o+4oxWv5kvqPoL8GTDegI8YrcfhBFJ/+PVV
         OgxVaQ/001AOznv/vVi0IoGWF2CurnfyKLBZ+RU5Ko5t22CKxJCA+yArI9t1H4UVtgyp
         wUNn4Pkub7oTaVFdNHfbaKf1kzJA2WCCPSsAW5rIKJmJBg911blQYXhOhhCnWG0ZVs39
         Wlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7F5D6u/WF0ZIAoHKqPGlh7cMjCdFB7jYX+uWCiO63w=;
        b=Tf4+uoXXK+hXC48g43oWXLQXW17+fHIgGooAOLjzYCBOkjGkwD1tOy1vZFSqFfUPw2
         fT1AaR4dN5Ie5zKcr5pq/1kTZjgr407wtbEEN+4Jwn+lXd0WycsiTs9qD+yq7m1RYa8t
         yM/QSix1H/fpysV0Adv4jncJE+QIUKU7HgyvTdBNYCbAFcgKvsZM+Sgrt4FLKkH4z23f
         D++XY8htceF956l9+J+Y0HQn0FHfKctLIdW4k4J67r0zajWOcw1WnoOP0F20uCqHI0Xm
         c8dzDhKddrHjnko0hFgfhkOAl63m9H3TAjRHBi2eYztuy9YzIS8janby1JZmv1AdZcKs
         /ZJQ==
X-Gm-Message-State: APzg51AxoT2jfMQCZOdN7P9DQRFFPh3KAiNP4YW3sWZW+bOC0TYSO5eA
        zdeIIYREMlUT3dqaD903KbWoci2MLMU=
X-Google-Smtp-Source: ANB0VdYSzUAQsBVZD6SY0zJh3TmIl0cKfB/QGdE1nSc/kH0OcfKJ1zD+eHfRRT7Xtt+Da6o2bhqEzw==
X-Received: by 2002:a2e:9791:: with SMTP id y17-v6mr10327331lji.41.1535723094072;
        Fri, 31 Aug 2018 06:44:54 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id f25-v6sm1776235ljc.97.2018.08.31.06.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 06:44:53 -0700 (PDT)
Subject: Re: [PATCH 10/23] wireless: remove unnecessary unlikely()
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Igor Stoppa <igor.stoppa@huawei.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
 <20180830223429.30051-11-igor.stoppa@huawei.com>
 <87va7qdfry.fsf@kamboji.qca.qualcomm.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <814defe0-72ab-049b-97cb-f295f4964895@gmail.com>
Date:   Fri, 31 Aug 2018 16:44:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87va7qdfry.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/08/18 12:52, Kalle Valo wrote:
> + linux-wireless

> IMHO you could fold patches 10, 11 and 12 into one to avoid having three
> patches with duplicate titles. Or alternatively use proper driver
> prefixes like "ath10k:", "b43:" and so on.

I was wondering if it would be ok to fold them, but it's easier to fold 
than to split, so I started with 3

> But how do you want these to be applied? For the wireless patches you
> didn't Cc linux-wireless so our patchwork won't see them and hence I
> can't take them. So if you want me to take these, please resend and
> include linux-wireless.


ok, I was hoping to avoid joining the ml but it's done
I had patches for about 20 different trees, so I decided to first see if 
the patches could be taken in right away.
In at least one case (pinctrl) I got lucky :-)

--
thanks, igor
