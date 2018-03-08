Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AG47ELtMNoz0JGnLHvdm01KJCGvInAeEswdyCNryoGf176rsud31kiipsrNDVZw/JlnohrjibQ9j
ARC-Seal: i=1; a=rsa-sha256; t=1520495763; cv=none;
        d=google.com; s=arc-20160816;
        b=QP9c4hHB3q7K/9LxS8RF5pi/iP/srWixAnwRpa5eZe840pL8CZZGsQi/EEYtijTBFy
         SQeThdpA1Cl3NgsvGgRMmqo3M37X3cP0pzOEP/QSxAfbm+gYcy+t5amRm/ZlHYxS2Y4O
         ugBSa42ZvvDxz26SAdYfSkz1hrmSh5QIXuCxO8nZNvYHLufnxGsItvsoS3BU4FYsDIph
         efQfJqTC3QoZiE4f5vUP4L2aHiaHRez3P71CHg4vk167Czt5kqrH5hS4z3iN7FVtaFvW
         d/lrp6VV0v/KzBp18FbxoloCw7QZ5me+JwPZjJqDZBHi9RkcWZPXU5T1qRlnfBSNFQyw
         H7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=SduYvknGCS8HSl8QMsxORzVngfFTNzVANykigZI8dlk=;
        b=w3ZajIn1HjowcdWkiTp6KVc+j+euiJSoxohUOvJqkhbwYJoZMea7Jepv36pGsN7Zl6
         X/pbEGVzrdqgu10rsvK5bIeHYScrRnEYszBNUyYBeT68Y0sIk/ooHihmjBHG29qaMjLx
         VFa5Mw0XRviJonAHO6uOknaecrcOV5VYs3OW/8qU1mgK1M6jEIb/5D9+u/i4QvD4FbUS
         cES7gAdq9SFLg9+wHS8SlIJjK0+IopTHuNE3BU/ZkweJZdfk66W1mIvh/r8g1dZn9YvK
         q6qf9ccIrTztoeHOlWvzNVBxEnN3NtzMyVxMGw1vBvwACQr3jnupkDsvyvUbpcAziSqM
         IVlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kP/2pau6;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=L/TiuNga;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kP/2pau6;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=L/TiuNga;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Mar 2018 13:26:02 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Timur Tabi
 <timur@codeaurora.org>
Subject: Re: [PATCH v12 3/6] PCI/PORTDRV: Implement generic find service
In-Reply-To: <ac53deae-8fad-b896-805f-36343253a34b@codeaurora.org>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <1519837457-3596-4-git-send-email-poza@codeaurora.org>
 <ac53deae-8fad-b896-805f-36343253a34b@codeaurora.org>
Message-ID: <73d083f125a11dbc6779dae6c0ffa6e3@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665114849236705?=
X-GMAIL-MSGID: =?utf-8?q?1594355365408915132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-06 19:32, Sinan Kaya wrote:
> On 2/28/2018 12:04 PM, Oza Pawandeep wrote:
>> +struct pcie_port_service_driver *pcie_port_find_service(struct 
>> pci_dev *dev,
>> +							u32 service)
>> +{
>> +	struct pcie_port_service_driver *drv = NULL;
> 
> Remove initialization
> 
>> +	struct portdrv_service_data pdrvs;
>> +
>> +	pdrvs.service = service;
> 
> initialize pdrvs.drv = NULL here.
> 
good point, will take care of this. [along with other comments if any]

>> +	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
>> +
>> +	drv = pdrvs.drv;
>> +	return drv;
>> +}
