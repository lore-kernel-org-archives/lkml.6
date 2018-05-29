Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966113AbeE2Syr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:54:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56814 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965425AbeE2Syn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:54:43 -0400
Subject: Re: [patch v25 4/4] Documentation: jtag: Add ABI documentation
To: Oleksandr Shamray <oleksandrs@mellanox.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au,
        jiri@resnulli.us, tklauser@distanz.ch, linux-serial@vger.kernel.org,
        vadimp@mellanox.com, system-sw-low-level@mellanox.com,
        robh+dt@kernel.org, openocd-devel-owner@lists.sourceforge.net,
        linux-api@vger.kernel.org, davem@davemloft.net, mchehab@kernel.org
References: <1527605618-15705-1-git-send-email-oleksandrs@mellanox.com>
 <1527605618-15705-5-git-send-email-oleksandrs@mellanox.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b1afae1e-b93b-3b86-1a45-ab0e408087e1@infradead.org>
Date: Tue, 29 May 2018 11:54:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527605618-15705-5-git-send-email-oleksandrs@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 07:53 AM, Oleksandr Shamray wrote:
> Added document that describe the ABI for JTAG class drivrer

Sorry, there are still a few typos.  Please see below.

> ---
>  Documentation/ABI/testing/gpio-cdev |    1 -
>  Documentation/ABI/testing/jtag-dev  |   23 +++++++
>  Documentation/jtag/overview         |   27 +++++++++
>  Documentation/jtag/transactions     |  109 +++++++++++++++++++++++++++++++++++
>  MAINTAINERS                         |    1 +
>  5 files changed, 160 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/ABI/testing/jtag-dev
>  create mode 100644 Documentation/jtag/overview
>  create mode 100644 Documentation/jtag/transactions
> 

> diff --git a/Documentation/jtag/overview b/Documentation/jtag/overview
> new file mode 100644
> index 0000000..f179095
> --- /dev/null
> +++ b/Documentation/jtag/overview
> @@ -0,0 +1,27 @@
> +Linux kernel JTAG support
> +=========================
> +
> +JTAG is an industry standard for verifying hardware.JTAG provides access to

needs space:
                                              hardware. JTAG provides

> +many logic signals of a complex integrated circuit, including the device pins.
> +
> +A JTAG interface is a special interface added to a chip.
> +Depending on the version of JTAG, two, four, or five pins are added.
> +
> +The connector pins are:
> +	TDI (Test Data In)
> +	TDO (Test Data Out)
> +	TCK (Test Clock)
> +	TMS (Test Mode Select)
> +	TRST (Test Reset) optional
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
> +User: ioctl -> /dev/jtagX -> JTAG core driver -> JTAG hardware specific driver
> +User: close -> /dev/jatgX

> diff --git a/Documentation/jtag/transactions b/Documentation/jtag/transactions
> new file mode 100644
> index 0000000..c5176a7
> --- /dev/null
> +++ b/Documentation/jtag/transactions
> @@ -0,0 +1,109 @@
> +The JTAG API
> +=============
> +
> +JTAG master devices can be accessed through a character misc-device.
> +Each JTAG master interface can be accessed by using /dev/jtagN.
> +
> +JTAG system calls set:
> +- SIR (Scan Instruction Register, IEEE 1149.1 Instruction Register scan);
> +- SDR (Scan Data Register, IEEE 1149.1 Data Register scan);
> +- RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
> +number of clocks.
> +
> +open(), close()
> +-------
> +open() opens JTAG device.
> +
> +Open/Close  device:
> +- jtag_fd = open("/dev/jtag0", O_RDWR);
> +- close(jtag_fd);
> +
> +ioctl()
> +-------
> +All access operations to JTAG devices are erformed through ioctl interface.

                                             performed

> +The IOCTL interface supports these requests:
> +	JTAG_IOCRUNTEST - Force JTAG state machine to RUN_TEST/IDLE state
> +	JTAG_SIOCFREQ - Set JTAG TCK frequency
> +	JTAG_GIOCFREQ - Get JTAG TCK frequency
> +	JTAG_IOCXFER - send JTAG data Xfer
> +	JTAG_GIOCSTATUS - get current JTAG TAP status
> +	JTAG_SIOCMODE - set JTAG mode flags.



-- 
~Randy
