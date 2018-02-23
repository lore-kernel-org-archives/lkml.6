Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754516AbeBWTRF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:17:05 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:39013 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeBWTRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:17:01 -0500
X-Google-Smtp-Source: AH8x227TG/uD7SmUmjt7eCZrCOz7w0aa4hn99/IRf534S9IwKmHPNpvpxleyXbHmhAQkD/h+5U991w==
To: linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, sbodomerle@gmail.com,
        rjui@broadcom.com
From: valmiki <valmikibow@gmail.com>
Subject: Affinity on non MSI-X interrupts
Message-ID: <714a8d82-c4b0-9661-5b78-ed0d87a0a5fc@gmail.com>
Date: Sat, 24 Feb 2018 00:47:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does multi MSI interrupts will also be set and routed by affinity ?

In drivers/pci/host/pcie-iproc-msi.c interrupt handler there is do while 
loop.
head = iproc_msi_read_reg(msi, IPROC_MSI_EQ_HEAD,
				  eq) & IPROC_MSI_EQ_MASK;
	do {
		tail = iproc_msi_read_reg(msi, IPROC_MSI_EQ_TAIL,
					  eq) & IPROC_MSI_EQ_MASK;

		.....
		}

		
		 */
	} while (true);

What happens if two multi MSI cards are connected and continuously 
running traffic ? Will this handler ever come out? wont this stall CPU ?
Will the interrupts be routed to different CPU's in this case also?

Regards,
Valmiki


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
