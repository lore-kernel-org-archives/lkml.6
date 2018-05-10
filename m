Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2470583-1525973148-2-1405372062738706869
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525973147; b=W7qTNx0Fy1BMInAxMvB3JE/HS42p+Q8Yp9/GlN1ay7LyU0kFnZ
    LO8bERcVDyfMCK5khEBXrBAFULFuW6VVLZprtQfrtYpCISDR+qfBVDaMtViOaTn5
    42mUoV3SdFna31dm2dfZbuyb2RBlgfgfbDhCTV/qsUaRxQQutpkvcALRqkTkAEHo
    VDlxRhaHd+5LWEudmEcqB/tLMLfaRSdR3XGbga6nO1CabNfjyI2IrQPOJKlhMFO8
    qEhrUpRjwTVMCwcAkquhv6BzcR9fmvZL36rxouCfXSoUyKsD1evawVrELQmK4hvT
    Iwjlhqq4JlwkfspylOHxLkwQs/hDyuLlqf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525973147;
    bh=Dw4pXqI9SxIib11vVeiKnCNfUT929S/Af02XVQFWOe8=; b=Qjqbbsn9ZYnF
    /3Q62ugGnqdUsFtrpNCeZqgFZhGH0s2T0xks0aHt77sxzkA2nEEf/iLt+EWJZeSi
    Zk+DylW+57fXWah9GP3Hw5Qj/owOUFI6MmZWbmnbq3uzf5xp1ic8gqIC84ywJLyc
    gqmjBNmi92+NH8XGCrMRhf2JjbuVDXxoqp2Pte9OGKD6j9EnBuJfcz38R0TK0lrP
    7Wr1N/zj3jhJ96IEVNIj2Rf2RA/KniXcxf6m5OFPUl7H0LUJ4MeSrcxmWgTOOfGU
    A1tzNdUI60c4INRra6fs6tTyIOxK/vXCKXkT+m7VDcYwjs8P+SdcOvyWHDlgj9kf
    jwTJ5z68eQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=SeMfM0yh
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=SeMfM0yh
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHfT9LspURHE6WkDYe0vvsrOA+Pg/8SJgSDZzewP5tgWmsh/PyWnbZkyJAPDXrMcOFO87qF5t1cI7Frz7gcFrO2/6j4wDrTzsAf/FOJvbwNVJXoZ0GSZ
    7lDt00KiaNkKER7HvEyeQ7m3KFjRc8QOCfsLY9Xsyy3hEhG1ZuW/+pRjRn+cbtIDr3W8ShIqCYt3nuq5f3BUkgdijzBMooHg4iQs5Af/6v+I4/p5plReJiNn
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8 a=pd0RXYg4yjbjvY6rcIEA:9
    a=1g5BqgqMvMLPyUtU:21 a=EyfbgnoZ8jeOzVDP:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1qrBK16LubpBFNPVNq2M:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966681AbeEJRZQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 13:25:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46336 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966663AbeEJRZD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 May 2018 13:25:03 -0400
Subject: Re: [patch v19 4/4] Documentation: jtag: Add ABI documentation
To: Oleksandr Shamray <oleksandrs@mellanox.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch,
        linux-serial@vger.kernel.org, vadimp@mellanox.com,
        system-sw-low-level@mellanox.com, robh+dt@kernel.org,
        openocd-devel-owner@lists.sourceforge.net,
        linux-api@vger.kernel.org, davem@davemloft.net, mchehab@kernel.org,
        Pavel Machek <pavel@ucw.cz>
References: <1525967064-10760-1-git-send-email-oleksandrs@mellanox.com>
 <1525967064-10760-5-git-send-email-oleksandrs@mellanox.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <987ed5f9-38c9-319e-ccd7-509b3a9eae1c@infradead.org>
Date: Thu, 10 May 2018 10:24:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525967064-10760-5-git-send-email-oleksandrs@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/10/2018 08:44 AM, Oleksandr Shamray wrote:
> Added document that describe the ABI for JTAG class drivrer
> 
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v18-v19
> Pavel Machek <pavel@ucw.cz>
> - Added JTAG doccumentation to Documentation/jtag
> 
> v17->v18
> v16->v17
> v15->v16
> v14->v15
> v13->v14
> v12->v13
> v11->v12
> Tobias Klauser <tklauser@distanz.ch>
> - rename /Documentation/ABI/testing/jatg-dev -> jtag-dev
> - Typo: s/interfase/interface
> v10->v11
> v9->v10
> Fixes added by Oleksandr:
> - change jtag-cdev to jtag-dev in documentation
> - update Kernel Version and Date in jtag-dev documentation;
> v8->v9
> v7->v8
> v6->v7
> Comments pointed by Pavel Machek <pavel@ucw.cz>
> - Added jtag-cdev documentation to Documentation/ABI/testing folder
> ---
>  Documentation/ABI/testing/jtag-dev |   27 +++++++++
>  Documentation/jtag/overview        |   31 ++++++++++
>  Documentation/jtag/transactions    |  108 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/jtag-dev
>  create mode 100644 Documentation/jtag/overview
>  create mode 100644 Documentation/jtag/transactions

> diff --git a/Documentation/jtag/overview b/Documentation/jtag/overview
> new file mode 100644
> index 0000000..e35afc0
> --- /dev/null
> +++ b/Documentation/jtag/overview
> @@ -0,0 +1,31 @@
> +Linux kernel JTAG support
> +=========================
> +
> +The JTAG (Joint Test Action Group) is an industry standard for hardware

just: JTAG
drop the "The"

maybe:                                                        for verifying
hardware designs
(although that's not quite what wikipedia says)

> +verifying designs and testing printed circuit boards after manufacture.
> +JTAG provides access to many logic signals of a complex integrated circuit,
> +including the device pins

                        pins.
Oh. Just drop the 2 lines above since they are repeated below.

> +
> +JTAG provides access to many logic signals of a complex integrated circuit,
> +including the device pins.
> +
> +A JTAG interface is a special interface added to a chip.
> +Depending on the version of JTAG, two, four, or five pins are added.
> +
> +The connector pins are:
> +	TDI (Test Data In)
> +	TDO (Test Data Out)
> +	TCK (Test Clock)
> +	TMS (Test Mode Select)
> +	TRST (Test Reset) optional.
> +
> +JTAG interface is supposed to have two parts - basic core driver and

                  is designed

> +hardware specific driver.
> +The basic driver introduces general interface which is not dependent of specific

                    introduces a general interface

> +hardware. It  provides communication between user space and hardware specific

                                                           and a hardware specific

> +driver.
> +Each JTAG device is represented as char device from (jtag0, jtag1, ...).

                                   as a char device

> +Access to JTAG device is performed through IOCTL call.

   Access to a JTAG device is performed through IOCTL calls.

> +
> +Call flow example:

   User: open /dev/jtagX

> +User (IOCTL) -> /dev/jtagX -> JTAG core driver -> JTAG hw specific driver

   User: close /dev/jtagX

> diff --git a/Documentation/jtag/transactions b/Documentation/jtag/transactions
> new file mode 100644
> index 0000000..91f7f92
> --- /dev/null
> +++ b/Documentation/jtag/transactions
> @@ -0,0 +1,108 @@
> +The JTAG API
> +=============
> +
> +JTAG master devices can be accessed through a character misc-device.
> +Each JTAG master interface can be accessed by using /dev/jtagN
> +
> +JTAG system calls set:
> +- SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);

     Why is SIR for                              Data Register?

> +- SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);

     Why is SDR for                       Instruction Register?

> +- RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
> +number of clocks.
> +
> +open(), close()
> +-------
> +open() opens JTAG device. Only one open operation per JTAG device
> +can be performed. Twice and more open for one device will return error

                     Two or more opens for one device will return errors.

> +
> +Open/Close  device:
> +- open('/dev/jtag0', O_RDWR);

     open("/dev/jtag0", O_RDWR);

> +- close(jtag_fd');

     close(jtag_fd);

> +
> +ioctl()
> +-------
> +All access operations to JTAG device performed trougth ioctl interface.

                                 devices are performed through the ioctl interface.

> +It support another requests:

   The IOCTL interface supports these requests:

> +	JTAG_IOCRUNTEST - Force JTAG state machine to RUN_TEST/IDLE state
> +	JTAG_SIOCFREQ - Set JTAG TCK frequency
> +	JTAG_GIOCFREQ - GET JTAG TCK frequency
> +	JTAG_IOCXFER - send JTAG data Xfer
> +	JTAG_GIOCSTATUS - get current JTAG TAP status
> +	JTAG_SIOCMODE - set JTAG mode flags.
> +
> +JTAG_SIOCFREQ, JTAG_GIOCFREQ
> +------
> +Set/Get JTAG clock speed:
> +
	unsigned int frq;

> +	ioctl(jtag_fd, JTAG_SIOCFREQ, &frq);
> +	ioctl(jtag_fd, JTAG_GIOCFREQ, &frq);
> +
> +JTAG_IOCRUNTEST
> +------
> +Force JTAG state machine to RUN_TEST/IDLE state
> +
> +struct jtag_run_test_idle {
> +	__u8	reset;
> +	__u8	endstate;
> +	__u8	tck;
> +};
> +
> +reset: 0 - run IDLE/PAUSE from current state
> +	   1 - go through TEST_LOGIC/RESET state before  IDLE/PAUSE
> +end: completion flag

   endstate:

> +tck: clock counter
> +
> +Example:
> +	struct jtag_run_test_idle runtest;
> +
> +	runtest.endstate = JTAG_STATE_IDLE;
> +	runtest.reset = 0;
> +	runtest.tck = data_p->tck;
> +	usleep(25 * 1000);
> +	ioctl(jtag_fd, JTAG_IOCRUNTEST, &runtest);
> +
> +JTAG_IOCXFER
> +------
> +Send SDR/SIR transaction
> +
> +struct jtag_xfer {
> +	__u8	type;
> +	__u8	direction;
> +	__u8	endstate;
> +	__u8	padding;
> +	__u32	length;
> +	__u64	tdio;
> +};
> +
> +type: transfer type - JTAG_SIR_XFER/JTAG_SDR_XFER
> +direction: xfer direction - JTAG_SIR_XFER/JTAG_SDR_XFER,
> +length: xfer data len in bits
> +tdio : xfer data array
> +endir: xfer end state after transaction finish

   endstate:

> +	   can be: JTAG_STATE_IDLE/JTAG_STATE_PAUSEIR/JTAG_STATE_PAUSEDR
> +
> +Example:
> +	struct jtag_xfer xfer;
> +	static char buf[64];
> +	static unsigned int buf_len = 0;
> +	[...]
> +	xfer.type = JTAG_SDR_XFER;
> +	xfer.tdio = (__u64)buf;
> +	xfer.length = buf_len;
> +	xfer.endstate = JTAG_STATE_IDLE;
> +
> +	if (is_read)
> +		xfer.direction = JTAG_READ_XFER;
> +	else
> +		xfer.direction = JTAG_WRITE_XFER;
> +
> +	ioctl(jtag_fd, JTAG_IOCXFER, &xfer);
> +
> +JTAG_SIOCMODE
> +------
> +If hw driver can support different running modes you can change it.
> +
> +Example:
> +	int mode;

+#define JTAG_SIOCMODE	_IOW(__JTAG_IOCTL_MAGIC, 5, unsigned int)
so:
	unsigned int mode;

> +	mode = JTAG_XFER_HW_MODE;
> +	ioctl(jtag_fd, JTAG_SIOCMODE, &mode);
> 


-- 
~Randy
