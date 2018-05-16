Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZrckN+NaMDr2BsSQF11ae3e0MO5zxZpd57SaamJwosBYmc1l+iaKbcRgJlqqLFzNG7CrwxR
ARC-Seal: i=1; a=rsa-sha256; t=1526494646; cv=none;
        d=google.com; s=arc-20160816;
        b=fPIpgcQsFxIkNFyfvhUVptFcA4T924BYGfSz92Kvr5oqGpjzivxtGSXNEQLveH1AzI
         IUGAh5pIb+vAyz0Lgj4QuUSxAkGkfHspw9awBZ4qXs5KHYfllPDisuxP+gC8BzasFszO
         HxMhTxfGUhLV/5Uo0hHLEdqS9NrINeySuRFOf9CvdtQLrkzwwJulztIrihbgKKZxw3/H
         Z2hDrtK82hQfF4PULTJ2qu03bymChFcbRtDk6aIyxw8/ORai4cMGIsKpd4w+BWkEd1b+
         ImfAq3ZDAFjnjqW62ZNhkld5cwvJ1H5rM2TcqPpF3+WK1E19UOSeaSc58aIgwzn7dLVA
         Eyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=6Y6c67k9kyU5Q59nxU0aSYRDClWz6O8+lcVVx7dufFY=;
        b=XxjrGl3B4FSchs+FjfAqBigJeqFrHPNKxAxvU2+lW5Qo2h2VfDMyrHShjVqD2tuRYr
         vifM9GYdZilWaPLyG31iJZNXuZpN71gQKa9VYYEyJ2F7nksEp5p74hzyY/D6HMs5kfkh
         GA0DIIkbft7zho1eCLu3kqFsG9zWJCivPLz4DhhQ3h5dfDZGiKQmbsQLCkuNJMMvnyL2
         HI45REDA5gYY87GXZqp7FDYlS5M81MoN+wmGOfAkrYrnCNOYif6gyKZ2wyV0lipjMv3f
         H7Wg2eTQGJfHsyPGqfcKghO6kzKW5hfRZkilJDIh1RFX0yQXfpVFTr1jHr0Lteomrh7J
         Bv/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=G79USmIY;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=G79USmIY;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [patch v21 4/4] Documentation: jtag: Add ABI documentation
To: Oleksandr Shamray <oleksandrs@mellanox.com>, gregkh@linuxfoundation.org,
 arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au,
 jiri@resnulli.us, tklauser@distanz.ch, linux-serial@vger.kernel.org,
 vadimp@mellanox.com, system-sw-low-level@mellanox.com, robh+dt@kernel.org,
 openocd-devel-owner@lists.sourceforge.net, linux-api@vger.kernel.org,
 davem@davemloft.net, mchehab@kernel.org
References: <1526394095-5069-1-git-send-email-oleksandrs@mellanox.com>
 <1526394095-5069-5-git-send-email-oleksandrs@mellanox.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <31c3b10e-7f8a-f997-4942-aed533d8801b@infradead.org>
Date: Wed, 16 May 2018 11:16:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526394095-5069-5-git-send-email-oleksandrs@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600540224664011548?=
X-GMAIL-MSGID: =?utf-8?q?1600645650801318111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/15/2018 07:21 AM, Oleksandr Shamray wrote:
> Added document that describe the ABI for JTAG class drivrer
> 
> ---
>  Documentation/ABI/testing/jtag-dev |   27 +++++++++
>  Documentation/jtag/overview        |   28 +++++++++
>  Documentation/jtag/transactions    |  109 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 164 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/jtag-dev
>  create mode 100644 Documentation/jtag/overview
>  create mode 100644 Documentation/jtag/transactions
> 

> diff --git a/Documentation/jtag/overview b/Documentation/jtag/overview
> new file mode 100644
> index 0000000..a86f188
> --- /dev/null
> +++ b/Documentation/jtag/overview
> @@ -0,0 +1,28 @@
> +Linux kernel JTAG support
> +=========================
> +
> +The JTAG is an industry standard for verifying hardware

   JTAG is an industry standard for verifying hardware.

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
> +JTAG interface is designed to have two parts - basic core driver and
> +hardware specific driver. The basic driver introduces a general interface
> +which is not dependent of specific hardware. It provides communication
> +between user space and hardware specific driver.
> +Each JTAG device is represented as a char device from (jtag0, jtag1, ...).
> +Access to a JTAG device is performed through IOCTL calls.
> +
> +Call flow example:
> +User: open  -> /dev/jatgX
> +User: ioctl -> /dev/jtagX -> JTAG core driver -> JTAG hw specific driver

                                                    JTAG hardware specific driver

> +User: close -> /dev/jatgX
> diff --git a/Documentation/jtag/transactions b/Documentation/jtag/transactions
> new file mode 100644
> index 0000000..6a857c8
> --- /dev/null
> +++ b/Documentation/jtag/transactions
> @@ -0,0 +1,109 @@
> +The JTAG API
> +=============
> +
> +JTAG master devices can be accessed through a character misc-device.
> +Each JTAG master interface can be accessed by using /dev/jtagN

                                                       /dev/jtagN.

> +
> +JTAG system calls set:
> +- SIR (Scan Instruction Register, IEEE 1149.1 Instruction Register scan);
> +- SDR (Scan Data Register, IEEE 1149.1 Data Register scan);
> +- RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
> +number of clocks.
> +
> +open(), close()
> +-------
> +open() opens JTAG device. Only one open operation per JTAG device
> +can be performed. Two or more open for one device will return error

                                                     will return error.

> +
> +Open/Close  device:
> +- open("/dev/jtag0", O_RDWR);
> +- close(jtag_fd');

     close(jtag_fd);

> +
> +ioctl()
> +-------
> +All access operations to JTAG devices performed through ioctl interface.
> +The IOCTL interface supports this requests:

                                these requests:

> +	JTAG_IOCRUNTEST - Force JTAG state machine to RUN_TEST/IDLE state
> +	JTAG_SIOCFREQ - Set JTAG TCK frequency
> +	JTAG_GIOCFREQ - Get JTAG TCK frequency
> +	JTAG_IOCXFER - send JTAG data Xfer
> +	JTAG_GIOCSTATUS - get current JTAG TAP status
> +	JTAG_SIOCMODE - set JTAG mode flags.
> +
> +JTAG_SIOCFREQ, JTAG_GIOCFREQ
> +------
> +Set/Get JTAG clock speed:
> +
> +	unsigned int jtag_fd;
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
> +endstate: completion flag
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
> +endstate: xfer end state after transaction finish
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

   If hardware driver

> +
> +Example:
> +	unsigned int mode;
> +	mode = JTAG_XFER_HW_MODE;
> +	ioctl(jtag_fd, JTAG_SIOCMODE, &mode);
> 


-- 
~Randy
