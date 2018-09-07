Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C343DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7FD2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="JjyJ87po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7FD2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeIGPI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:08:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33268 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbeIGPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:08:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so6836723pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7B9C3By63DyMEjbEsmsj2UX3qWpuTYwBcERevatxV9Y=;
        b=JjyJ87po4SwRUUfaRGmbMStoyvBYBwQaEQTH2ul55xUTHKLdOJXqYbzD8B6sGvOxXb
         dlScnnxm539NzVzGC+C+3U6W1skMuzWa8in1om2Av45HZGHmXN6hXR8SAteggUTOFxxz
         KnoLhesxx7neHIM8az/Wmb+Fu33JzgOkigeCHBu3f7/T/E5vQAd69gDaaFC75UzkvxLk
         57ooMkZNrxA1SNSe3gI8PWmcQGautKhIh5P+DSHxX0FmxM39zv/4MBQmDtp4C2OG4TVB
         cFJ+bFi+i6tDff91sDeZyJxyWRzb9eZHlubqsDXcFEHPK+k7BLZOL1F1JQJr6QThSW7P
         kSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7B9C3By63DyMEjbEsmsj2UX3qWpuTYwBcERevatxV9Y=;
        b=lEAHkcs2yk06aZf/sS1Q8m1vMymWgNiuLR37wSuDqNAWhfN8XDVAz+V6wFURvyzatJ
         Y4nPPd2OfDdrMECcLKk7O3fPbr2kNeRjm/lgnSJLXTGZFvKI/XjGEaR95vUiwAJs8Cau
         Y1OBqORSA7wXevCaxuls+UyjhaB9BHaUEONX84Put2aDbCEuIq7/ErPaIwhOEQ0PqKcc
         9C2DnE2e9D/q5ts6DIGVYGPtO6IQYJ2ET/JYt4nMwhzHUFLR2VSgDXUhPw5fhtFU0RkF
         qnhn/PRRy0k92UytUG1ZKQBzvK+HMLtJ8L7tNc/QskKqgxhz3rPLOL+R+a3RDTzalbXh
         Jy+w==
X-Gm-Message-State: APzg51DKZes9ndJ+lH2QJeGVjVN4NG+5RoJO6BgExGKI++IRm5hzbUd8
        UqbiyTe8v5P5h9moIGeQNYOmtg==
X-Google-Smtp-Source: ANB0VdYGTV6V7MG2fQFhjnBtMnoApnz351pekYPGqPebceOeDIjeIvPyqCWqyEEW858yEDba9Z7rKw==
X-Received: by 2002:a63:6c89:: with SMTP id h131-v6mr7409368pgc.237.1536316118579;
        Fri, 07 Sep 2018 03:28:38 -0700 (PDT)
Received: from [10.86.62.183] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id e26-v6sm9500928pfi.70.2018.09.07.03.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:28:37 -0700 (PDT)
Subject: Re: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
To:     javier@javigon.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4ac29eb8-65bf-f733-d196-80c5bb41876c@lightnvm.io>
Date:   Fri, 7 Sep 2018 12:28:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 12:09 PM, Javier González wrote:
> In the OCSSD 2.0 spec., the sector and metadata sizes are reported though
> the standard nvme identify command. Thus, the lightnvm subsystem needs
> to update this information on the geometry structure on bootup.
> 
> Since 1.2 devices report these values on the OCSSD geometry identify,
> avoid this update is it is unnecessary and can also corrupt the geometry
> if the devices does not report the nvme sizes correctly (which is not
> required by the OCSSD 1.2 spec either) >
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/nvme/host/lightnvm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 5bfa354c5dd5..33ed09f8410e 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -980,6 +980,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>   	struct nvm_dev *ndev = ns->ndev;
>   	struct nvm_geo *geo = &ndev->geo;
>   
> +	if (geo->version == NVM_OCSSD_SPEC_12)
> +		return;

The lba format sizes are not explicit in 2.0 either. For a conforming 
drive, it should implement the NVM Command Set and expose the LBA format 
correctly. Although, I do get your incentive, and if it is okay with 
you, I'll reword the commit message to this and apply it?:

"1.2 devices exposes their data and metadata size through the separate
identify command. Make sure that the NVMe LBA format does not override
these values."


> +
>   	geo->csecs = 1 << ns->lba_shift;
>   	geo->sos = ns->ms;
>   }
> 


