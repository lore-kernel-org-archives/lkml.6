Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D2BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DB0208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DB0208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeH1Eft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:35:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:61008 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725753AbeH1Eft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:35:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 17:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,297,1531810800"; 
   d="gz'50?scan'50,208,50";a="85451610"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2018 17:45:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fuS88-000Ht0-A3; Tue, 28 Aug 2018 08:45:12 +0800
Date:   Tue, 28 Aug 2018 08:44:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Karoly Pados <pados@pados.hu>
Cc:     kbuild-all@01.org, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karoly Pados <pados@pados.hu>
Subject: Re: [PATCH] USB: serial: ftdi_sio: implement GPIO support for FT230X
Message-ID: <201808280850.fKB9HokO%fengguang.wu@intel.com>
References: <20180825204744.2307-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20180825204744.2307-1-pados@pados.hu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Karoly,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on usb-serial/usb-next]
[also build test ERROR on v4.19-rc1 next-20180827]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Karoly-Pados/USB-serial-ftdi_sio-implement-GPIO-support-for-FT230X/20180827-005902
base:   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git usb-next
config: mips-rm200_defconfig (attached as .config)
compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   drivers/usb/serial/ftdi_sio.c: In function 'ftdi_sio_port_probe':
>> drivers/usb/serial/ftdi_sio.c:2090:30: error: passing argument 1 of 'ftdi_sio_gpio_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
     result = ftdi_sio_gpio_init(port);
                                 ^~~~
   drivers/usb/serial/ftdi_sio.c:2030:12: note: expected 'struct usb_serial *' but argument is of type 'struct usb_serial_port *'
    static int ftdi_sio_gpio_init(struct usb_serial *serial)
               ^~~~~~~~~~~~~~~~~~
   drivers/usb/serial/ftdi_sio.c: In function 'ftdi_sio_port_remove':
>> drivers/usb/serial/ftdi_sio.c:2213:23: error: passing argument 1 of 'ftdi_sio_gpio_remove' from incompatible pointer type [-Werror=incompatible-pointer-types]
     ftdi_sio_gpio_remove(port);
                          ^~~~
   drivers/usb/serial/ftdi_sio.c:2035:13: note: expected 'struct usb_serial *' but argument is of type 'struct usb_serial_port *'
    static void ftdi_sio_gpio_remove(struct usb_serial *serial)
                ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/ftdi_sio_gpio_init +2090 drivers/usb/serial/ftdi_sio.c

  2065	
  2066	static int ftdi_sio_port_probe(struct usb_serial_port *port)
  2067	{
  2068		struct ftdi_private *priv;
  2069		const struct ftdi_sio_quirk *quirk = usb_get_serial_data(port->serial);
  2070		int result;
  2071	
  2072		priv = kzalloc(sizeof(struct ftdi_private), GFP_KERNEL);
  2073		if (!priv)
  2074			return -ENOMEM;
  2075	
  2076		mutex_init(&priv->cfg_lock);
  2077	
  2078		if (quirk && quirk->port_probe)
  2079			quirk->port_probe(priv);
  2080	
  2081		usb_set_serial_port_data(port, priv);
  2082	
  2083		ftdi_determine_type(port);
  2084		ftdi_set_max_packet_size(port);
  2085		if (read_latency_timer(port) < 0)
  2086			priv->latency = 16;
  2087		write_latency_timer(port);
  2088		create_sysfs_attrs(port);
  2089	
> 2090		result = ftdi_sio_gpio_init(port);
  2091		if (result < 0)
  2092			dev_err(&port->serial->interface->dev,
  2093				"GPIO initialisation failed: %d\n",
  2094				result);
  2095	
  2096		return 0;
  2097	}
  2098	
  2099	/* Setup for the USB-UIRT device, which requires hardwired
  2100	 * baudrate (38400 gets mapped to 312500) */
  2101	/* Called from usbserial:serial_probe */
  2102	static void ftdi_USB_UIRT_setup(struct ftdi_private *priv)
  2103	{
  2104		priv->flags |= ASYNC_SPD_CUST;
  2105		priv->custom_divisor = 77;
  2106		priv->force_baud = 38400;
  2107	}
  2108	
  2109	/* Setup for the HE-TIRA1 device, which requires hardwired
  2110	 * baudrate (38400 gets mapped to 100000) and RTS-CTS enabled.  */
  2111	
  2112	static void ftdi_HE_TIRA1_setup(struct ftdi_private *priv)
  2113	{
  2114		priv->flags |= ASYNC_SPD_CUST;
  2115		priv->custom_divisor = 240;
  2116		priv->force_baud = 38400;
  2117		priv->force_rtscts = 1;
  2118	}
  2119	
  2120	/*
  2121	 * Module parameter to control latency timer for NDI FTDI-based USB devices.
  2122	 * If this value is not set in /etc/modprobe.d/ its value will be set
  2123	 * to 1ms.
  2124	 */
  2125	static int ndi_latency_timer = 1;
  2126	
  2127	/* Setup for the NDI FTDI-based USB devices, which requires hardwired
  2128	 * baudrate (19200 gets mapped to 1200000).
  2129	 *
  2130	 * Called from usbserial:serial_probe.
  2131	 */
  2132	static int ftdi_NDI_device_setup(struct usb_serial *serial)
  2133	{
  2134		struct usb_device *udev = serial->dev;
  2135		int latency = ndi_latency_timer;
  2136	
  2137		if (latency == 0)
  2138			latency = 1;
  2139		if (latency > 99)
  2140			latency = 99;
  2141	
  2142		dev_dbg(&udev->dev, "%s setting NDI device latency to %d\n", __func__, latency);
  2143		dev_info(&udev->dev, "NDI device with a latency value of %d\n", latency);
  2144	
  2145		/* FIXME: errors are not returned */
  2146		usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
  2147					FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
  2148					FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
  2149					latency, 0, NULL, 0, WDR_TIMEOUT);
  2150		return 0;
  2151	}
  2152	
  2153	/*
  2154	 * First port on JTAG adaptors such as Olimex arm-usb-ocd or the FIC/OpenMoko
  2155	 * Neo1973 Debug Board is reserved for JTAG interface and can be accessed from
  2156	 * userspace using openocd.
  2157	 */
  2158	static int ftdi_jtag_probe(struct usb_serial *serial)
  2159	{
  2160		struct usb_device *udev = serial->dev;
  2161		struct usb_interface *interface = serial->interface;
  2162	
  2163		if (interface == udev->actconfig->interface[0]) {
  2164			dev_info(&udev->dev,
  2165				 "Ignoring serial port reserved for JTAG\n");
  2166			return -ENODEV;
  2167		}
  2168	
  2169		return 0;
  2170	}
  2171	
  2172	static int ftdi_8u2232c_probe(struct usb_serial *serial)
  2173	{
  2174		struct usb_device *udev = serial->dev;
  2175	
  2176		if (udev->manufacturer && !strcmp(udev->manufacturer, "CALAO Systems"))
  2177			return ftdi_jtag_probe(serial);
  2178	
  2179		if (udev->product &&
  2180			(!strcmp(udev->product, "Arrow USB Blaster") ||
  2181			 !strcmp(udev->product, "BeagleBone/XDS100V2") ||
  2182			 !strcmp(udev->product, "SNAP Connect E10")))
  2183			return ftdi_jtag_probe(serial);
  2184	
  2185		return 0;
  2186	}
  2187	
  2188	/*
  2189	 * First two ports on JTAG adaptors using an FT4232 such as STMicroelectronics's
  2190	 * ST Micro Connect Lite are reserved for JTAG or other non-UART interfaces and
  2191	 * can be accessed from userspace.
  2192	 * The next two ports are enabled as UARTs by default, where port 2 is
  2193	 * a conventional RS-232 UART.
  2194	 */
  2195	static int ftdi_stmclite_probe(struct usb_serial *serial)
  2196	{
  2197		struct usb_device *udev = serial->dev;
  2198		struct usb_interface *interface = serial->interface;
  2199	
  2200		if (interface == udev->actconfig->interface[0] ||
  2201		    interface == udev->actconfig->interface[1]) {
  2202			dev_info(&udev->dev, "Ignoring serial port reserved for JTAG\n");
  2203			return -ENODEV;
  2204		}
  2205	
  2206		return 0;
  2207	}
  2208	
  2209	static int ftdi_sio_port_remove(struct usb_serial_port *port)
  2210	{
  2211		struct ftdi_private *priv = usb_get_serial_port_data(port);
  2212	
> 2213		ftdi_sio_gpio_remove(port);
  2214	
  2215		remove_sysfs_attrs(port);
  2216	
  2217		kfree(priv);
  2218	
  2219		return 0;
  2220	}
  2221	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--8t9RHnE3ZwKMSgU+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--8t9RHnE3ZwKMSgU+--
