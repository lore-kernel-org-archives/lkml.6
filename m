Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4ADC28CF8
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 01:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E5520835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 01:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7BcdA2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E5520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeJNJP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 05:15:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37240 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeJNJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 05:15:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so7527682pgq.4;
        Sat, 13 Oct 2018 18:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0xrM+U9xk4O5DdHUFiPDREHSEJxehWKw9gtd2caCuLo=;
        b=X7BcdA2kUb74A0cVCUeLQAJ8jM71BwAcIuhzxZW7URjLRUYqZ+PX5axOmxw2BKz5K7
         aw3FtYwhHkVn4TYUBLlCGezZkI0MyX5iJF+SFAsAf+NO2IfV5TZn7dkxG8bWd/YwmE62
         NINVdC3KRnNUy+954Rl3cxg6B+r2ytRA17oVqh9fTT1vB9CV61KXyHFEyxI4XjXL4Px2
         97gf82SMhpiLDwloliTnRsCRRap1QPxpmjfAqDhT60IHtIiMnItC1249PkUTVIdaZzaN
         bao5L5wYu84p4Ax03RpVtV0Ue5QvVYpXTo5IaNJRFgf2nYOR/a4rVAQyig3BPL7Ii6I9
         fH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0xrM+U9xk4O5DdHUFiPDREHSEJxehWKw9gtd2caCuLo=;
        b=MCPaEcf1ZXG0dMyYkO//TNNvzZcZvegPZh2/OMzqU4SOgjmQJs9SPQZRoiWWfTZmNQ
         +tuWyOt1d9EUI4p+wIMYFZhwxjnlw2qnNbp4ZQI/7+gcbh6ARHZfUQFDKc8k+mqcISbH
         xgMyidwopldU08iMxM7z8SqlNWmr7rUJCLT9asTXxO3ZnAqkiaSCy1e5iZtdHxqVx3/H
         wybiR07iF3ipp2LK7FZJxJX0awERl++Pk9/c3gzrne3FHIFLE/Z7zCMR5AYmDr16+CNw
         QBB4u3H5UlfJaKDslcPBa2UOpMQCPDd+dOhyxq7yLZOqG91ASTlod0xlPICOj2vxyYN+
         QXEA==
X-Gm-Message-State: ABuFfoj9Dn6uv6ATmw87VD35NJGWVn+5OiXqQCk8Rzgb/vtnRUj/NsoI
        zsQKpL3Yb5/m8SQEktXgSzZ6VQ7z
X-Google-Smtp-Source: ACcGV62XyeJtMEFRE9U6+DoPkyVE/3sHoqCvh2jMCxpZVOGrrRt5vi3kZzOIvWnFxlBaqcvRfh76Mw==
X-Received: by 2002:a62:5e02:: with SMTP id s2-v6mr12493653pfb.146.1539481004257;
        Sat, 13 Oct 2018 18:36:44 -0700 (PDT)
Received: from [192.168.1.101] (122-62-216-69-adsl.sparkbb.co.nz. [122.62.216.69])
        by smtp.gmail.com with ESMTPSA id t22-v6sm8668414pfk.141.2018.10.13.18.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 18:36:43 -0700 (PDT)
Subject: Re: [PATCH 0/6] mac_esp, zorro_esp, esp_scsi: Various improvements
To:     Finn Thain <fthain@telegraphics.com.au>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <cover.1539391876.git.fthain@telegraphics.com.au>
Cc:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <38b7cb8f-6adf-7097-d33c-7824dd9c013c@gmail.com>
Date:   Sun, 14 Oct 2018 14:36:51 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1539391876.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 13.10.2018 um 13:51 schrieb Finn Thain:
> This series has fixes and cleanup for mac_esp, zorro_esp and the
> core esp_scsi driver.
>
> The improvements include elimination of duplicated code temporarily
> introduced for zorro_esp.
>
> Michael, would you please regression test this series on elgar,
> if convenient? So far, only mac_esp has been tested with this code.
>
>
> Finn Thain (6):
>   zorro_esp: Limit DMA transfers to 65535 bytes
>   esp_scsi: Track residual for PIO transfers
>   esp_scsi: Grant disconnect privilege for untagged commands
>   esp_scsi: Eliminate ESP_FLAG_DOING_SLOWCMD
>   esp_scsi: De-duplicate PIO routines
>   esp_scsi: Optimize PIO loops
>
>  drivers/scsi/esp_scsi.c  | 192 +++++++++++++++++++++++++++++--------
>  drivers/scsi/esp_scsi.h  |  10 +-
>  drivers/scsi/mac_esp.c   | 171 ++-------------------------------
>  drivers/scsi/zorro_esp.c | 240 +++++++----------------------------------------
>  4 files changed, 201 insertions(+), 412 deletions(-)
>

For Amiga zorro-esp:

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
