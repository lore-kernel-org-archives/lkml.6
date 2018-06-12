Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 85CCBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389AC20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHFh6V8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389AC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754232AbeFLFui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:50:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35868 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbeFLFug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:50:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id v131-v6so20682211wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 22:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DUDg3R7vShHGeNRzW/8z3SwRHzQjOgczlSzPM6meXOE=;
        b=JHFh6V8wqyNeL6kqS8bGI8Mpfm5ZF01SdaaDr4PyNWqhdOmpSG6EkVuGCb/LmyIyi4
         Gp3MZOM5ivqxMlm/sOd005SxFHreVbdehl0EvBvAMBUePHR9sFINGkPEJnqXMRrfIeep
         TOyQa+wJ4hK56/DBYb/95rb/E7HCqseaj8Pwdx/L0+obefR3coCdweQvPZddK5ZAGGco
         FNkaT50TAhVmDXIx9vd0QEx1xFwcYSh1S0pf24ZG9j5ngeS5ht2zd0IW55oP7Osg/FIg
         tUDHb0kbNRi+Q6CEG35fBEoEqasjsp9Ey7RmtMihgTQtqBqkKI0dq1jbB08i5dyB23Sn
         +3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DUDg3R7vShHGeNRzW/8z3SwRHzQjOgczlSzPM6meXOE=;
        b=bqW02XRb5GDjwu2TpHDtw6Pu/cJXgtVjleo5Nfkm+22WCUrniFQWaDU6vdyHu6A89W
         qQWJfWIcLX4x6eWhHtN4gEl796A9/jX9ltTInhs0etjiyY7eJvbFL+KbRxKRR0SsFfyh
         N/xEcxiwyCcP9RmkD2DJoYYLbSjtH79EXYN4/KqnakbhBmegm2ADz9vHp+RjCOwM7wBU
         2UkI9mWJuaCAHbjUEIp/gCC0BzM3tZvaHeqUo6NHuYaVWFeAfZ4J4eWqXM4ydxECze1j
         HR8N+v9MpPnZ1yzv4QpWE6gXsKkhGEMxy3mnzIauUC44dUQFi53bhY3Tv3kxbitY7EFi
         QvhA==
X-Gm-Message-State: APt69E11Vx+jiI3/kvcjDsBC2aJ5g5Eg81UzHSGMxPFYxSUYWKiq+5ym
        ZrOK1/VIe7Y5aIoUplWFx7OtXhJm
X-Google-Smtp-Source: ADUXVKKKc+fv12iEJ9PX3QXIZAXz7aHjiPaJRPooiz6OIbgDYLMIED6+eV94tlxfOtEOPDIFGiTZbA==
X-Received: by 2002:a1c:d650:: with SMTP id n77-v6mr1179537wmg.140.1528782635210;
        Mon, 11 Jun 2018 22:50:35 -0700 (PDT)
Received: from [172.22.36.62] (redhat-nat.vtp.fi.muni.cz. [78.128.215.6])
        by smtp.gmail.com with ESMTPSA id y8-v6sm155238wrs.0.2018.06.11.22.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 22:50:34 -0700 (PDT)
Subject: Re: [Query] Failed to create dm-crypt device when using AEAD type
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, agk@redhat.com,
        snitzer@redhat.com
Cc:     broonie@linaro.org, arnd@arndb.de, joakim.bech@linaro.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <33220afd-9a26-6133-ebf0-83b1268c34b7@huawei.com>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <9aebff4d-71b0-9fe0-2ccc-38c80fc2179a@gmail.com>
Date:   Tue, 12 Jun 2018 07:50:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.3.0
MIME-Version: 1.0
In-Reply-To: <33220afd-9a26-6133-ebf0-83b1268c34b7@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 07:37 AM, Xiongfeng Wang wrote:
> Hi Dm-crypt maintainers,
> 
> Recently, I was testing the dm-crypt, but I failed to create dm-crypt device when using AEAD type.
> I would really appreciate it if you could give some help.
> The error info is as follows:
> localhost:~ # export SIZE_INT=997376
> 8 J 0"ost:~ # dmsetup create integ1 --table "0 $SIZE_INT integrity /dev/sdd2 0 2
> localhost:~ #
> dom \host:~ # dmsetup create crypt1 --table "0 $SIZE_INT crypt capi:gcm(aes)-ran
>>  11ff33c6fb942655efb3e30cf4c0fd95f5ef483afca72166c530ae26151dd83b \
>>  0 /dev/mapper/integ1 0 1 integrity:28:aead"
> [ 1746.631559] device-mapper: crypt: Integrity AEAD, tag size 16, IV size 12.
> [ 1746.649796] device-mapper: crypt: INTEGRITY AEAD ERROR, sector 997248
> [ 1746.656382] device-mapper: crypt: INTEGRITY AEAD ERROR, sector 997248
> [ 1746.662826] Buffer I/O error on dev dm-3, logical block 124656, async page read

These errors actually say that it works as expected! :)

If the underlying device has no integrity tags initialized, *every* access to device must generate
integrity fail (because integrity tag is just not correct).

And the errors above are perhaps udev scans that are triggered by inotify when new device appears
and it tries to find some signatures on uninitialized disk with blkid.

If you use cryptsetup, it will try to wipe the device, alternatively you can use
dd (just be sure to use direct-io, page cache can generate some reads that fails as well),
so in your case something like this:

  # dd if=/dev/zero of=/dev/maper/crypt1 bs=1M oflag=direct

should wipe the device (and store integrity tags).

If you activate your devices again (with the same parameters), no integrity errors should be present.

(I will write more documentation in next weeks regarding all this stuff, we have now better
AEAD ciphers in 4.18.)

Thanks,
Milan
 
> 
> I tested it both on qemu and hardware, and it printed the same error.
> The error seems always on the last several sectors within the SIZE_INT I designated.
> When I change the SIZE_INT, the error sector num also change.
> I think something went wrong in the software, not the hardware.
> 
> My board don't have AEAD accelerator, so it uses the software implemented cipher.
> My kernel version is 4.17-rc3.
> 
> The command is as follows:
> export SIZE_INT=997376
> dmsetup create integ1 --table "0 $SIZE_INT integrity /dev/sdd2 0 28 J 0"
> dmsetup create crypt1 --table "0 $SIZE_INT crypt capi:gcm(aes)-random \
>  11ff33c6fb942655efb3e30cf4c0fd95f5ef483afca72166c530ae26151dd83b \
>  0 /dev/mapper/integ1 0 1 integrity:28:aead"
> 
> This command comes from the commit information of the commit which introduce AEAD.
> (commit ef43aa38063a6b2b3c6618e28ab35794f4f1fe29
> dm crypt: add cryptographic data integrity protection (authenticated encryption))
> I only change 'aes-gcm-random' to 'capi:gcm(aes)-random'
> 
> Really appreciate it if you could have a look at it, Thanks!
> 
> Regards,
> Xiongfeng
> 
> 
