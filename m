Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754624AbeE2G23 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:28:29 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:54288 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeE2G2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:28:25 -0400
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
To: Randy Dunlap <rdunlap@infradead.org>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        "Vinayak Holikatti <vinholikatti@gmail.com>; \"James E.J. Bottomley\"
        <jejb@linux.vnet.ibm.com>; \"Martin K. Petersen\""
        <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org; Manjunath M Bettegowda
        <manjumb@synopsys.com>; Prabu Thangamuthu <prabut@synopsys.com>; Tejas
        Joglekar <joglekar@synopsys.com>; Joao Pinto"
        <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 3/5] scsi: ufs: Add Kconfig for UFS HC driver crypto
 support
Thread-Topic: [PATCH 3/5] scsi: ufs: Add Kconfig for UFS HC driver crypto
 support
Thread-Index: AQHT9ptv3PTZ50Tbn0qmk/Lw5IHWDA==
Date: Tue, 29 May 2018 06:28:18 +0000
Message-ID: <BD7FB879CC136E419544C8E2AE7B9C3020B71A@IN01WEMBXA.internal.synopsys.com>
References: <9baaf314-e9de-a078-1085-9c81b3421d42@synopsys.com>
 <394042f2-2231-37c9-f875-979415dbdf58@infradead.org>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.239.235]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4T6SbqS030569

On Monday 28 May 2018 04:49 PM, Randy Dunlap wrote:
> On 05/28/2018 06:29 AM, Ladvine D Almeida wrote:
>>
>> This patch adds the Kconfig for enabling crypto support for
>> UFS Host Controller driver. It also adds Makefile changes
>> for building crypto support based on crypto Kconfig selection.
>>
>> Signed-off-by: Ladvine D Almeida <ladvine@synopsys.com>
>> ---
>>  drivers/scsi/ufs/Kconfig  | 15 +++++++++++++++
>>  drivers/scsi/ufs/Makefile |  6 +++++-
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
>> index e27b4d4..0134672 100644
>> --- a/drivers/scsi/ufs/Kconfig
>> +++ b/drivers/scsi/ufs/Kconfig
>> @@ -50,6 +50,21 @@ config SCSI_UFSHCD
>>  	  However, do not compile this as a module if your root file system
>>  	  (the one containing the directory /) is located on a UFS device.
>>  
>> +config SCSI_UFSHCD_INLINE_ENCRYPTION
>> +	bool "Universal Flash Storage Controller Driver crypto support"
>> +	depends on SCSI_UFSHCD
>> +	default n
>> +	select BLK_DEV_INLINE_ENCRYPTION if SCSI_UFSHCD_INLINE_ENCRYPTION
>> +	help
>> +	This enables the Inline Encryption feature of the UFS Host
>> +	Controller driver. Once the capability is detected in hardware,
>> +	it will be made available for the user through Linux Kernel
>> +	Cryptography Framework(LKCF).
> 
> The help text above should be indented (as below), with one tab + 2 spaces.
> 
   Sure, I will send v2 patch with the corrected indentation.
>> +
>> +	  If you have a controller with this capability, say Y.
>> +
>> +	  If unsure, say N.
>> +
>>  config SCSI_UFSHCD_PCI
>>  	tristate "PCI bus based UFS Controller support"
>>  	depends on SCSI_UFSHCD && PCI
> 
> 

Best Regards,
Ladvine
