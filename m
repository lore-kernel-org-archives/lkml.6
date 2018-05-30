Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968590AbeE3Btn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:49:43 -0400
Received: from feh.colobox.com ([209.177.154.210]:59578 "EHLO feh.colobox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968432AbeE3Btk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:49:40 -0400
Subject: Re: [PATCH V3 1/2] PCI: Try to clean up resources via remove if
 shutdown doesn't exist
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
From: Ryan Finnie <ryan@finnie.org>
Message-ID: <0bf8bfe6-370d-8794-d205-f3ff51f23f4c@finnie.org>
Date: Tue, 29 May 2018 18:49:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 02:21 PM, Sinan Kaya wrote:
> It is up to a driver to implement shutdown() callback. If shutdown()
> callback is not implemented, PCI device can have pending interrupt and
> even do DMA transactions while the system is going down.
> 
> If kexec is in use, this can damage the newly booting kexec kernel
> or even prevent it from booting altogether. Fallback to calling the
> remove() callback if shutdown() isn't implemented for a given driver.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
> Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
> Cc: stable@vger.kernel.org
> Reported-by: Ryan Finnie <ryan@finnie.org>

Tested successfully on DL360 Gen9 and DL380 Gen9.

Tested-by: Ryan Finnie <ryan@finnie.org>
