Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C56C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C8425D9A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iob3wAOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C8425D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeGBNVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:21:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41096 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbeGBNVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:21:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so15528394wrq.8;
        Mon, 02 Jul 2018 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0diT0olf1JszXilW7085EJtFA3VQVQMcMhBK0cKmzWg=;
        b=iob3wAOKV4hWRXo7F8SaaiFQ26a2QSz2AvqRm3AsxhAeivh8LrpAU9TxMKeHFXR1tS
         iPKHTMg7ABuxSQUelzvJg4f2HpJ+XkNSXCYJ0QwxceSVjUl7Qvc5XIGRMYFteh4l23r/
         2GRBRiu+B9dOLF7c5ykTDO1BuZ9Q+SY9s3Aj/vBy2vuCDGOvFaYn7HB4IL4bKhmAuW8t
         M6B28QRYtl0tiNJ7HM4X+M9rkCVaE9Mw3oxCRvkv1iz7UcsUuxfsX4XunF7rw6/CfWeB
         At+S9c01875DwmZsgaBOZ1Fw3zI+RokNTHdTzOvOEy3+zRXvM0/qu/VSFRnSSxxbEGTK
         CkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=0diT0olf1JszXilW7085EJtFA3VQVQMcMhBK0cKmzWg=;
        b=pfPFoRY+o/5x3zMm4woxlXo7c2NMiP+0ulS0jETgH1/0rlRETLle0yQfrndCwxv8RY
         DWSARoCRcHZs2N1kWfK3WqQ2324TQnwxQuu3zXiTyUSn2S70Bmwj/VL/rBmrVuyMheum
         gAZr/JFjgYj+tCUncjikdabrcAP7dI7jevVcuB17kxnVbHthI7AgS30unz+N3OW9O0tz
         0cpzifcS5iM/2WQH25xvSvfYOMZqbXZY4bQrPbks/BB6y3pbg69qaA0Z+9/CPyiKFse7
         hLDkQaucIsXwSlTr+27g5vuE4wWuwdvQobAm6VaE0ahz2VMYdmMF0Uv3oCrz3TLzTBlc
         WwmA==
X-Gm-Message-State: APt69E3zId9UTGGVjZpdaBdYfkslRKv013H99a2lxEQab5+5zG7+uOdv
        wnPr7gW/Q62BzIDnhuBydcMUDOim
X-Google-Smtp-Source: AAOMgpcvsyKrxRlaKjH2w9HpprUR01tpjNTmsJiO4YCPoR2cfC1Z+NaiH8dbjJqWZDA8q5Fl3ggB+Q==
X-Received: by 2002:adf:d142:: with SMTP id b2-v6mr14220783wri.17.1530537660824;
        Mon, 02 Jul 2018 06:21:00 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id f2-v6sm18247574wre.16.2018.07.02.06.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 06:21:00 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/2] PCI: fix restoring resized BAR state on resume
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180614122146.62118-1-christian.koenig@amd.com>
 <20180630005718.GJ40928@bhelgaas-glaptop.roam.corp.google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <064ebaf7-8953-fd29-a688-26a5646111a0@gmail.com>
Date:   Mon, 2 Jul 2018 15:20:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180630005718.GJ40928@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.06.2018 um 02:57 schrieb Bjorn Helgaas:
> On Thu, Jun 14, 2018 at 02:21:45PM +0200, Christian König wrote:
>> Resize BARs after resume to the expected size again.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199959
>> CC: stable@vger.kernel.org      # v4.15+
> I applied both of these to pci/resource for v4.19, thanks!  It'd be nice to
> have them in v4.18, but since it's not a regression and the problem has
> been there since v4.15, I'm not sure I could justify it.

Well it is a regression. The change to enable this in the upstream 
driver was added in 4.16, but a good bunch of people also compile our 
backported DKMS module.

And now those people are complaining that the driver stopped working 
after resume in 4.15 with the DKMS module and with 4.16 with the 
upstream module.

Alternatively I can disable resizing from the driver from kernels older 
than v4.19.

Christian.

>
>> ---
>>   drivers/pci/pci.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index bd6f156dc3cf..d4685090378b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1159,6 +1159,33 @@ static void pci_restore_config_space(struct pci_dev *pdev)
>>   	}
>>   }
>>   
>> +static void pci_restore_rebar_state(struct pci_dev *pdev)
>> +{
>> +	unsigned int pos, nbars, i;
>> +	u32 ctrl;
>> +
>> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
>> +	if (!pos)
>> +		return;
>> +
>> +	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>> +	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
>> +		    PCI_REBAR_CTRL_NBAR_SHIFT;
>> +
>> +	for (i = 0; i < nbars; i++, pos += 8) {
>> +		struct resource *res;
>> +		int bar_idx, size;
>> +
>> +		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>> +		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
>> +		res = pdev->resource + bar_idx;
>> +		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
>> +		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
>> +		ctrl |= size << 8;
>> +		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
>> +	}
>> +}
>> +
>>   /**
>>    * pci_restore_state - Restore the saved state of a PCI device
>>    * @dev: - PCI device that we're dealing with
>> @@ -1174,6 +1201,7 @@ void pci_restore_state(struct pci_dev *dev)
>>   	pci_restore_pri_state(dev);
>>   	pci_restore_ats_state(dev);
>>   	pci_restore_vc_state(dev);
>> +	pci_restore_rebar_state(dev);
>>   
>>   	pci_cleanup_aer_error_status_regs(dev);
>>   
>> -- 
>> 2.14.1
>>

