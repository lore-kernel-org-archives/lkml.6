Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBDEC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513AA26EE5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFl6zCob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513AA26EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755081AbeFZUvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:51:06 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46578 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbeFZUvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:51:04 -0400
Received: by mail-ot0-f195.google.com with SMTP id v24-v6so20539368otk.13;
        Tue, 26 Jun 2018 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cl+mM50p3IHChjRN6un1uQeklSSkXHaqbNpjQ4EO0T8=;
        b=mFl6zCobpHcGElvmg3EwyAaGvixdIOLdGUfl9bqRzyGM6SBAurwfHkbEsLn8fcI3VR
         YaXFb6NAmUPwEVOzqnwMfgfnXPYhF+nZNJcz0RB6HE9pKJNBDFGjnfIo1uQ+8J/NMNGc
         2Zi2m9SN+JCITmkuMWQlw39TDVo9n9alwNatS2P2AuXsIiONlxinRVdjNiKn0HvFU1Rl
         nC7xdayzbnqAVP6xxhqXWbi0pm4mR546jmEw76TAbv+ZU5aG0FgUV0RJNij1+cYj98N3
         NO5X8e3TtMhICZVRiUWrp2Q0cNALhgDbePT17/XFmwNc1bD+KIUugwDKZYHCaz2Ie2m0
         beBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cl+mM50p3IHChjRN6un1uQeklSSkXHaqbNpjQ4EO0T8=;
        b=jzDAEkhP0tgL669h/BSFVJrxt3dQVkIuYIQS5m/l9ZnHd7P0F89kyvii6ilrjtL2kc
         bX9E2IF+ur7G1VhOJhe82O2WESYsf1ZoweCxbVd8DkbxFTknEQsJf3bIU/TCmSeyztAM
         habeyTzdTYu7+mIAXNV0dKuYGQ0J5wUIIgkS0J0fJqHkSkB0IMjIIL6ZFCC641FZ6o1Y
         35+LjsttE9kjukvM0tHeJwbIkq5ldI44nsNix4Y70ynEe/Rai0dbjMQNNE7RORM6NgpY
         6GosdP2WITB2MziwP8+7q4O8Bmi8I9kJZohl5oJSTNTO14VLhWuq1OZSRjPnWZmYsgnM
         CHxw==
X-Gm-Message-State: APt69E3r/AYr9tVD1OouOOkPNr3eNgsnWKNtQRKxSh+PmcH+bemrHJ+H
        cQ0H9HXZSKE49uq3wVR/T8gwdOO+zWE=
X-Google-Smtp-Source: AAOMgpd2xjQNGSNZlJWCVTBkDgbfVJ0cgtPOraK/iyMB03Vq/LqUJRGekVY1j9L60zyanfro0odOCg==
X-Received: by 2002:a9d:538a:: with SMTP id w10-v6mr1684635otg.30.1530046263716;
        Tue, 26 Jun 2018 13:51:03 -0700 (PDT)
Received: from nuclearis2_1.gtech (c-98-201-114-184.hsd1.tx.comcast.net. [98.201.114.184])
        by smtp.gmail.com with ESMTPSA id r3-v6sm845447oig.49.2018.06.26.13.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 13:51:03 -0700 (PDT)
Subject: Re: [PATCH] PCI: DPC: Clear AER status bits before disabling port
 containment
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>
Cc:     Sinan Kaya <okaya@codeaurora.org>, bhelgaas@google.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Dongdong Liu <liudongdong3@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180516213306.27027-1-mr.nuke.me@gmail.com>
 <605540c0-b6c5-89a2-9d50-12a3005d9f88@codeaurora.org>
 <20180516231220.GA21659@localhost.localdomain>
 <20180619215720.GE33049@bhelgaas-glaptop.roam.corp.google.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <bcaa5398-3306-7b25-3d1f-d2f0568fc72a@gmail.com>
Date:   Tue, 26 Jun 2018 15:51:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180619215720.GE33049@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/19/2018 04:57 PM, Bjorn Helgaas wrote:
> On Wed, May 16, 2018 at 05:12:21PM -0600, Keith Busch wrote:
>> On Wed, May 16, 2018 at 06:44:22PM -0400, Sinan Kaya wrote:
>>> On 5/16/2018 5:33 PM, Alexandru Gagniuc wrote:
>>>> AER status bits are sticky, and they survive system resets. Downstream
>>>> devices are usually taken care of after re-enumerating the downstream
>>>> busses, as the AER bits are cleared during probe().
>>>>
>>>> However, nothing clears the bits of the port which contained the
>>>> error. These sticky bits may leave some BIOSes to think that something
>>>> bad happened, and print ominous messages on next boot. To prevent this,
>>>> tidy up the AER status bits before releasing containment.
>>>>
>>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>>> ---
>>>>  drivers/pci/pcie/dpc.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>>>> index 8c57d607e603..bf82d6936556 100644
>>>> --- a/drivers/pci/pcie/dpc.c
>>>> +++ b/drivers/pci/pcie/dpc.c
>>>> @@ -112,6 +112,10 @@ static void dpc_work(struct work_struct *work)
>>>>  		dpc->rp_pio_status = 0;
>>>>  	}
>>>>  
>>>> +	/* DPC event made a mess of our AER status bits. Clean them up. */
>>>> +	pci_cleanup_aer_error_status_regs(pdev);
>>>> +	/* TODO: Should we also use aer_print_error to log the event? */
>>>> +
>>>>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>>>>  		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
>>>>  
>>>>
>>>
>>> I think Keith has a patch to fix this. It was under review at some point.
>>
>> Right, I do intend to following up on this, but I've had some trouble
>> finding time the last few weeks. Sorry about that, things will clear up
>> for me shortly.
> 
> I'll drop this (Alexandru's) patch for now, waiting for your update, Keith.

I wonder if clearing AER status bits is mutually exclusive with
refactoring other parts of DPC handling?

Alex
