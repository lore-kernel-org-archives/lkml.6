Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16B6C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3EF2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfANEyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 23:54:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45946 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANEyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 23:54:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so9740807pfd.12;
        Sun, 13 Jan 2019 20:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bmcxAxzuAHpblo8399IJcpn1FuL4nYi4F3M/k+AHpn4=;
        b=oVE5WhphFIZlPoJVmhsNJ7QEEgvCPfkmvwheTD7mRP31qk7NvhzFzkMu2orTmwZ1YI
         wIwVaVKmxTeAeYNutImrJO1Z2DJ0TDnFqEMHZHSU2yoxxhdvh6DBssjbkSWhftytIRWg
         GrlslIuW4oFxrgp5gbslhHSgIIiOi7rSaKYVZknk/F+kqe3VXen53sKMINedMODETKrE
         Ua+6HgU0w7Qy3pmPg1SDWWbf0lKVVDLmvoIez7WQ2RJkHoBB4BPe2oC1EKHeUnuYtrug
         cdS7uA1XScFmfTLdh5gMZtbUECvLs3tWqyKZR7NIhmRtnTAWT6XK7e5S2yfHP9tLYOPl
         CKcw==
X-Gm-Message-State: AJcUukdU6OVcw7jRA7wF75BfOovq243gOo3bRFX1wbh/JISTEf/DLReF
        JT/P5aXK8hkY3tFTRjO5+Cw=
X-Google-Smtp-Source: ALg8bN48y1VWyuwvj9aJRtFHsoBVrYEf+tP2OohmfGRUhyGVcrv62DkiCCbqsPbPE0jk4K5VBnPyvw==
X-Received: by 2002:a62:22d4:: with SMTP id p81mr11723996pfj.16.1547441677526;
        Sun, 13 Jan 2019 20:54:37 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id v89sm127336305pfk.12.2019.01.13.20.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 20:54:36 -0800 (PST)
Subject: Re: [PATCH v3] scsi/ata: Use unsigned int for cmd's type in ioctls in
 scsi_host_template
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        Don Brace <don.brace@microsemi.com>,
        Brian King <brking@us.ibm.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joel Stanley <joel@jms.id.au>
References: <20181020050143.589-1-natechancellor@gmail.com>
 <20190114044206.6351-1-natechancellor@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c1f7f039-04b2-a660-2408-8d4ac0ea63c4@acm.org>
Date:   Sun, 13 Jan 2019 20:54:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190114044206.6351-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/19 8:42 PM, Nathan Chancellor wrote:
> @@ -1292,7 +1292,7 @@ int esas2r_ioctl_handler(void *hostdata, int cmd, void __user *arg)
>   	ioctl = memdup_user(arg, sizeof(struct atto_express_ioctl));
>   	if (IS_ERR(ioctl)) {
>   		esas2r_log(ESAS2R_LOG_WARN,
> -			   "ioctl_handler access_ok failed for cmd %d, "
> +			   "ioctl_handler access_ok failed for cmd %u, "
>   			   "address %p", cmd,
>   			   arg);
>   		return PTR_ERR(ioctl);

If you have to repost this patch, please use that opportunity to join 
the above split strings. Additionally, since this patch touches much 
more SCSI code than ATA code I think it should have been sent to Martin 
instead of to Jens. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

