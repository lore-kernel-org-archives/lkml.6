Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeBZJkr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:40:47 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:36980 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751697AbeBZJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:40:45 -0500
Subject: Re: regression: SCSI/SATA failure
To: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
        "hch@lst.de" <hch@lst.de>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sth@linux.vnet.ibm.com" <sth@linux.vnet.ibm.com>,
        "Herring, Jan-kristian Augustin"
        <jan-kristian.augustin.herring@intel.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <1519311270.2535.53.camel@intel.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <01b8159e-ed51-1913-5335-ce342c3be649@leemhuis.info>
Date: Mon, 26 Feb 2018 10:40:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519311270.2535.53.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1519638045;cab41b23;
X-HE-SMSGID: 1eqFGq-000535-SF
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JFYI: This issues is tracked in the regression reports for Linux 4.16
(http://bit.ly/lnxregrep416 ) with this id:

Linux-Regression-ID: lr#15a115

Please include this line in the comment section of patches that are
supposed to fix the issue. Please also mention the string once in other
mailinglist threads or different bug tracking entries if you or someone
else start to discuss the issue there. By including that string you make
it a whole lot easier to track where an issue gets discussed and how far
patches to fix it have made it. For more details on this please see
here: http://bit.ly/lnxregtrackid

Thx for your help. Ciao, Thorsten

On 22.02.2018 15:54, Bityutskiy, Artem wrote:
> Hi Christoph,
> 
> one of our test box Skylake servers does not boot with v4.16-rcX.
> Bisection lead us to this commit:
> 
> 84676c1f21e8 genirq/affinity: assign vectors to all possible CPUs
> 
> Reverting this single commit fixes the problem.
> 
> The server is a Dell R640 machine with the latest Dell BIOS. It has a
> single SATA SSD and we do not use raid, even though the system does
> have a megaraid controller.
> 
> Are you aware of this issue? Below is the failure message and the full
> dmesg with some debugging boot parameters is here:
> 
> https://pastebin.com/raw/tTYrTAEQ
> 
> [  201.706075] sd 14:2:0:0: [sda] tag#0 task abort called for scmd(00000000c342d874)
> [  201.720357] sd 14:2:0:0: [sda] tag#0 CDB: Read(10) 28 00 0d e7 ff 80 00 00 08 00
> [  201.734621] sd 14:2:0:0: task abort: FAILED scmd(00000000c342d874)
> [  201.754134] sd 14:2:0:0: target reset called for scmd(00000000c342d874)
> [  201.767566] sd 14:2:0:0: [sda] tag#0 megasas: target reset FAILED!!
> [  201.780690] sd 14:2:0:0: [sda] tag#0 Controller reset is requested due to IO timeout
> [  201.780690] SCSI command pointer: (00000000c342d874)  SCSI host state: 5      SCSI 
> [  201.809709] IO request frame:
> [  201.809709] 
> [  201.809710] f1000000 
> [  201.827987] 00000000 
> [  201.836901] 00000000 
> [  201.846047] 5d880000 
> [  201.855161] 00600002 
> [  201.864093] 00000020 
> [  201.872746] 00000000 
> [  201.881168] 00001000 
> [  201.889432] 
> [  201.889432] 
> [  201.897570] 00000000 
> [  201.912011] 0000000a 
> [  201.919897] 00000000 
> [  201.927608] 00000000 
> [  201.935275] 00000000 
> [  201.943047] 00000000 
> [  201.950516] 00000000 
> [  201.957709] 02000000 
> [  201.964776] 
> [  201.964776] 
> [  201.971731] e70d0028 
> [  201.983967] 000080ff 
> [  201.990676] 00000008 
> [  201.997192] 00000000 
> [  202.003611] 00000000 
> [  202.009812] 00000000 
> [  202.015847] 00000000 
> [  202.021770] 00000000 
> [  202.027576] 
> [  202.027576] 
> [  202.033382] 00140012 
> [  202.043209] 00000009 
> [  202.048521] 0de7ff80 
> [  202.053711] 00000000 
> [  202.058818] 00000008 
> [  202.063850] 00000000 
> [  202.068797] 00020100 
> [  202.073549] 00000000 
> [  202.078131] 
> [  202.078131] 
> [  202.082708] beb56000 
> [  202.089903] 0000002f 
> [  202.094106] 00001000 
> [  202.098230] 40000000 
> [  202.102238] 00000000 
> [  202.106134] 00000000 
> [  202.109878] 00000000 
> [  202.113456] 00000000 
> [  202.117008] 
> [  202.117008] 
> [  202.120545] 00000000 
> [  202.126100] 00000000 
> [  202.129656] 00000000 
> [  202.133191] 00000000 
> [  202.136716] 00000000 
> [  202.140241] 00000000 
> [  202.143767] 00000000 
> [  202.147264] 00000000 
> [  202.150772] 
> [  202.150772] 
> [  202.154257] 00000000 
> [  202.159702] 00000000 
> [  202.163206] 00000000 
> [  202.166706] 00000000 
> [  202.170204] 00000000 
> [  202.173697] 00000000 
> [  202.177186] 00000000 
> [  202.180659] 00000000 
> [  202.184135] 
> [  202.184135] 
> [  202.187592] 00000000 
> [  202.192952] 00000000 
> [  202.196440] 00000000 
> [  202.199892] 00000000 
> [  202.203349] 00000000 
> [  202.206798] 00000000 
> [  202.210252] 00000000 
> [  202.213691] 00000000 
> [  202.217140] 
> 
