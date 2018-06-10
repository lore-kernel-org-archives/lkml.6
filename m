Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pneQE2xsHFvjQAAAmS7hNA
	; Sun, 10 Jun 2018 00:25:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 27153608B8; Sun, 10 Jun 2018 00:25:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 582B7605A2;
	Sun, 10 Jun 2018 00:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 582B7605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=scientia.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753552AbeFJAY5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 20:24:57 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:35939 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753435AbeFJAY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 20:24:56 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-02.dd24.net (Postfix) with ESMTP id BB7EC5FC7D;
        Sun, 10 Jun 2018 00:24:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from mailgw-02.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id w0m_IkpYtmRP; Sun, 10 Jun 2018 00:24:52 +0000 (UTC)
Received: from [192.168.0.102] (p54B6DCC8.dip0.t-ipconnect.de [84.182.220.200])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw-02.dd24.net (Postfix) with ESMTPSA;
        Sun, 10 Jun 2018 00:24:52 +0000 (UTC)
Message-ID: <f5b20fde635fdb46140851b1bd1ce096d6ee8a12.camel@scientia.net>
Subject: Re: sd 6:0:0:0: [sdb] Unaligned partial completion (resid=12,
 sector_sz=512)
From: Christoph Anton Mitterer <calestyo@scientia.net>
To: dgilbert@interlog.com, linux-kernel@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>
Date: Sun, 10 Jun 2018 02:24:51 +0200
In-Reply-To: <071361b8-96c0-17cd-d1d7-61ea6357eb83@interlog.com>
References: <c35dacb574365736229ff04d587abc0390ef7b78.camel@scientia.net>
         <f96c1329-929b-44a1-4c3a-74dbcedbbafe@infradead.org>
         <2cbab96cfb722ef8ad8f9fe6f5060226108cf033.camel@scientia.net>
         <071361b8-96c0-17cd-d1d7-61ea6357eb83@interlog.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-09 at 20:10 -0400, Douglas Gilbert wrote:
> Hmmm, probably yes. But before you throw it away, try running
> 'smartctl -a'

Knew I forgot to add something. SMART looks fine (see below), though I
haven't run a new long check (and will only do so once I've done
copying the data from the device (I should have still 2 further backups
of it, though also on Seagate ST8000AS0002).

I think all values are pretty normal (all Seagates seem to show these
high numbers for Raw_Read_Error_Rate, Seek_Error_Rate and
Hardware_ECC_Recovered. Never had a Seagate disk which didn't. Guess
it's normal for them).

The only thing which is a bit strange are the:
Command_Timeout 6
High_Fly_Writes 5
though I have low values of these on most of my
ST8000AS0002.
So I'd blindly guess it's mostly normal, too.

Does anyone know something different?



Thanks,
Chris.


Below, the smartctl data:

smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.16.0-2-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Archive HDD
Device Model:     ST8000AS0002-1NA17Z
Serial Number:    
LU WWN Device Id: 5 000c50 08742d013
Firmware Version: AR15
User Capacity:    8,001,563,222,016 bytes [8,00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5980 rpm
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-2, ACS-3 T13/2161-D revision 3b
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sat Jun  9 20:39:43 2018 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)	Offline data collection activity
					was completed without error.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		(    0) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine 
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 ( 930) minutes.
Conveyance self-test routine
recommended polling time: 	 (   2) minutes.
SCT capabilities: 	       (0x30a5)	SCT Status supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   117   099   006    Pre-fail  Always       -       121016704
  3 Spin_Up_Time            0x0003   090   090   000    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age   Always       -       334
  5 Reallocated_Sector_Ct   0x0033   100   100   010    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   081   060   030    Pre-fail  Always       -       152829073
  9 Power_On_Hours          0x0032   099   099   000    Old_age   Always       -       953
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   Always       -       262
183 Runtime_Bad_Block       0x0032   100   100   000    Old_age   Always       -       0
184 End-to-End_Error        0x0032   100   100   099    Old_age   Always       -       0
187 Reported_Uncorrect      0x0032   100   100   000    Old_age   Always       -       0
188 Command_Timeout         0x0032   100   099   000    Old_age   Always       -       6
189 High_Fly_Writes         0x003a   095   095   000    Old_age   Always       -       5
190 Airflow_Temperature_Cel 0x0022   074   054   045    Old_age   Always       -       26 (Min/Max 26/26)
191 G-Sense_Error_Rate      0x0032   100   100   000    Old_age   Always       -       0
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       317
193 Load_Cycle_Count        0x0032   100   100   000    Old_age   Always       -       415
194 Temperature_Celsius     0x0022   026   046   000    Old_age   Always       -       26 (0 18 0 0 0)
195 Hardware_ECC_Recovered  0x001a   117   099   000    Old_age   Always       -       121016704
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
240 Head_Flying_Hours       0x0000   100   253   000    Old_age   Offline      -       901 (11 170 0)
241 Total_LBAs_Written      0x0000   100   253   000    Old_age   Offline      -       28367482688
242 Total_LBAs_Read         0x0000   100   253   000    Old_age   Offline      -       468926342278

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%       900         -
# 2  Extended offline    Completed without error       00%       702         -
# 3  Extended offline    Aborted by host               90%       638         -
# 4  Extended offline    Aborted by host               90%       637         -
# 5  Extended offline    Aborted by host               90%       631         -
# 6  Extended offline    Interrupted (host reset)      00%       629         -
# 7  Extended offline    Aborted by host               90%       374         -
# 8  Extended offline    Aborted by host               90%       371         -
# 9  Extended offline    Interrupted (host reset)      00%       370         -
#10  Extended offline    Completed without error       00%        85         -
#11  Short offline       Completed without error       00%         0         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.
