Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD58C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBE220882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBE220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeILMz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:59 -0400
Received: from smtp.infotech.no ([82.134.31.41]:43364 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeILMz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 2D7B520423B;
        Wed, 12 Sep 2018 09:52:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NBhtFxBbNAOJ; Wed, 12 Sep 2018 09:52:34 +0200 (CEST)
Received: from [192.168.48.23] (host-45-58-207-169.dyn.295.ca [45.58.207.169])
        by smtp.infotech.no (Postfix) with ESMTPA id 9DFBF20418A;
        Wed, 12 Sep 2018 09:52:33 +0200 (CEST)
Reply-To: dgilbert@interlog.com
To:     SCSI development list <linux-scsi@vger.kernel.org>
Cc:     Martin Pitt <mpitt@debian.org>,
        David Sommerseth <davids@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Ritesh Raj Sarraf <rrs@researchut.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Subject: [Announce] sg3_utils-1.43 available
Message-ID: <41f0edec-9ff6-607c-5423-bab120ca964b@interlog.com>
Date:   Wed, 12 Sep 2018 03:52:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sg3_utils is a package of command line utilities for sending
SCSI commands to storage devices. It some contexts it can
send some ATA and NVMe commands. The package targets the Linux
4, 3, 2.6 and 2.4 kernel series. It has ports to FreeBSD, Android,
Solaris, and Windows (cygwin and MinGW).

For an overview of sg3_utils and downloads see this page:
     http://sg.danny.cz/sg/sg3_utils.html
The sg_ses utility (for enclosure devices) is discussed at:
     http://sg.danny.cz/sg/sg_ses.html
A full changelog can be found at:
     http://sg.danny.cz/sg/p/sg3_utils.ChangeLog


Changelog summary for sg3_utils-1.43 [20180911 rev 789] since
version 1.42 [20160217]

   New utilities
     - sg_bg_ctl: send Background control command (sbc4r08)
     - sg_seek: send SEEK(10) or PRE-FETCH(10 or 16)
     - sg_stream_ctl: send STREAM CONTROL or GET STREAM STATUS
     - sg_write_x: send either WRITE(n), ORWRITE(n), WRITE ATOMIC(n),
       WRITE SAME(n), WRITE SCATTERED(n) or WRITE STREAM(n); where 'n'
       is 16 or 32 which is the length of the cdb

   New general options:
     - --dry-run option added to utilities that would otherwise modify
       user data and potentially take a long time. Utilties that the
       --dry-run option has been added to: sg_dd, sg_format, sgm_dd,
       sgp_dd, sg_sanitize, sg_ses_microcode, sg_unmap, sg_write_buffer
       and sg_write_x
     - --timeout=SECS option for extending the default command OS
       timeout added to: sg_compare_and_write, sg_format, sg_raw,
       sg_sanitize, sg_senddiag, sg_sync, sg_unmap, sg_write_buffer,
       sg_write_same, sg_write_verify, and sg_write_x

   Take input from file rather than SCSI device
     The number of 'decoding' utilities that can take input from a file
     rather than a SCSI device has been expanded. This allows data to be
     collected as hex or binary files and later analysed. Utilities
     that have this facility are: sg_inq, sg_logs, sg_read_attr, sg_ses
     and sg_vpd. The sdparm utility, in its own package, decodes mode
     pages (and VPD pages) now has this facility while the sg_modes
     utility does not.

   NVMe support
     NVMe have chosen to use the SES-3 standard with the addition
     of the NVME-MI SES Send and Receive admin commands. Rather than
     modify sg_ses, the underlying library has a small SNTL used when
     the given device is a NVMe device. sg_ses (and sg_ses_microcode)
     can now be used with a NVMe enclosure. sg_inq decodes part of
     the NVME Identify controller and namespace response. sg_raw can
     issue NVMe admin commands and sg_senddiag can issue SES Send and
     Receive admin commands.

   Page align many heap allocations
     Both NVMe and certain FreeBSD pass-through calls require page
     alignment. So many (but not all) malloc() calls have been replaced
     by sg_memalign() which is a front for posix_memalign() if it is
     available. Typically the default page size (often 4096 (bytes)) is
     used for alignment.

   Individual utility additions
     - rescan-scsi-bus.sh: harden code, install by default
       - add --ignore-rev to ignore revision change
     - sg_dd: add --verbose option; allow multiple short options (e.g. -dvv)
     - sgp_dd: pthread_cancel() has issues in C++ (and the Android
       multi-threaded library doesn't supply it) so use pthread_kill()
     - add --dry-run and --verbose options
     - sg_decode sense: add --cdb and --err=ES options
     - sg_format: add --quick option to skip reconsideration time
       - extend --wait timeout to 40 hours for disk sizes > 4 TB
     - sg_get_lba_status: add --report-type= option (sbc4r12)
       - add support for 32 byte cdb variant (sbc4r14)
       - add support for --element-id= and --scan-len= options (sbc4r14)
       - decode response's RTP and two more provisioning statuses and the
         additional status (sbc4r12); decode completion condition (sbc4r14)
     - sg_inq: fix potential unbounded loop in --export
       - add --only to stop standard inquiry decoding also doing a serial
         number vpd page (0x80) fetch
       - with NVMe --only restricts to a single Identify controller command
       - add --long which decodes more of the NVMe Identify cmd responses
     - sg_inq+sg_vpd: update Extended inquiry data vpd page (spc5r09,
       spc5r17 and 17-142r5)
       - add --force option to bypass checking Supported VPD Pages page and
         fetch requested page directly
     - sg_logs: add --vendor=VP and '--pdt=DT' options
     - sg_modes: add Out of band management control mpage
       - accept acronym for mode page
     - sg_opcode: add '--enumerate' and '--pdt=' options; support CDLP
       (command duration limit page) and MLU (Multiple Logical Units)
     - sg_persist: add --maxlen-LEN option, LEN defaults to decimal, similar
       to --alloc-length= which takes hex; add Replace Lost Reservation
       Capable (RLR_C) bit in Report Capabilities (spc4r36)
     - sg_raw: add --cmdfile=CF option, CF in hex unless --raw option also
       given; this and other tweaks facilitate sending 64 byte NVMe admin
       commands to be sent
       - add --enumerate option to decode command name from cdb
     - sg_rdac: add sanity checks for -f=lun value
     - sg_rep_zones: expand --help option information
     - sg_reset_wp add --count=ZC option, zbc2r01b
     - sg_sat_identify: expand to take --len=32
     - sg_ses: handle 2 bit EIIOE field in aes dpage
       - add --quiet option to suppress messages
       - allow multiple --clear=, --get= and --set= options
       - allow individual index ranges (e.g. --index=3-5)
       - allow --index=IIA with -ee to enumerate only fields belonging to
         element type IIA
     - sg_ses_microcode: add -ealsd option (exit after last send diagnostic)
     - sg_timestamp: add '--no-timestamp', '--elapsed' and '--hex' options
     - sg_turs: add --low option to force low level sg_pt interface use
     - sg_unmap: add --all=ST,RN[,LA] option to unmap large contiguous
       segments of a disk/ssd
     - sg_vpd: 3 party copy VPD page improvements
       - fully implement Device constituents VPD page
     - sg_wr_mode: add --rtd option for RTD bit
     - sg_zone: add --sequentialize, --count=ZC options, zbc2r01b

Doug Gilbert
