Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AG47ELuBQ+IPpvTDOkg6+NKgnXNc2lpDnoAQncVA5euQhz6k9K8BQl4+O7Z1TzTroxE4fRC3UOR9
ARC-Seal: i=1; a=rsa-sha256; t=1521467057; cv=none;
        d=google.com; s=arc-20160816;
        b=07EpzmOJWKN3UX7xv+pUUZDqZ965pitiLj9YxYOj4MratgH5Xi5+aYBGiRTb/Ifq++
         fwy9ESBnrNKSX9NWTKk71qsuAUODXoXmo/Asmo8E+9MVxY+bwri3t1V177bGX/XZPHxr
         iAiaDmO8koZRK+rjLF497dPDHJRsybpVN58iJl5d102/Oa6HeFxduj4BrZ5oUhIT1cmn
         6unMG60CZTnmyEUH4ulh0ZVFVs27qpQNcM6VylTPmjI1uXxzAv3+q4vAI/dAXD1J+8RW
         1vWNtA/qHp0Y459u60f6XZ0RjvbL1TcsCeWSNqvf+w04jtOGGeZ3Nh7KJJJ1Z1++rdgp
         MRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5RkjiqrqFvuwG+gNtjeuda7QNmig2LNv6W+AV2QX7PE=;
        b=y399K17Qws4AHCj69CHc0x4GWuLIAhM2HxQJbyb5bkFu/R6G/ulOA3um81i8g7Dnri
         GA2dmbKdKY6KKgHaPI4L5gg4CESr0uTZTummUbL5MbFe3TbYRv9TLhTa+YblEs76IjqX
         C1L25v3q2f5bBCSDIGYpXxtpSKux9IBFDBdfUTtWLLlD2hStSIQocT/k7DLRv3Kw8hpj
         oKvXDYWjI7oUOGFi8c7zYGMl1dbB+1sDNTnhM17o5ITZf3OtPR1AMtAmScszFLWDhpcI
         QsaXRapbHwP+nxUo4CwUK3fdDPaWHou/r8W7/P7EDTqxDexIv975By3s2QoSt1fqK/po
         Ya8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,330,1517904000";
   d="gz'50?scan'50,208,50";a="212900034"
Date: Mon, 19 Mar 2018 21:43:29 +0800
From: kbuild test robot <lkp@intel.com>
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: kbuild-all@01.org, Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Jorge <jorge.sanjuan@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ALSA: usb: initial USB Audio Device Class 3.0
 support
Message-ID: <201803192103.TpMCRTC7%fengguang.wu@intel.com>
References: <1521423963-24677-3-git-send-email-ruslan.bilovol@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <1521423963-24677-3-git-send-email-ruslan.bilovol@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595328661372171880?=
X-GMAIL-MSGID: =?utf-8?q?1595373840546369312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ruslan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc6 next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ruslan-Bilovol/ALSA-usb-audio-move-audioformat-quirks-to-quirks-c/20180319-205541
config: i386-randconfig-x016-201811 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   sound/usb/stream.c: In function 'snd_usb_parse_audio_interface':
>> sound/usb/stream.c:956:8: warning: 'fmt' may be used uninitialized in this function [-Wmaybe-uninitialized]
       if (snd_usb_parse_audio_format(chip, fp, format,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           fmt, stream) < 0) {
           ~~~~~~~~~~~~

vim +/fmt +956 sound/usb/stream.c

   628	
   629	int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
   630	{
   631		struct usb_device *dev;
   632		struct usb_interface *iface;
   633		struct usb_host_interface *alts;
   634		struct usb_interface_descriptor *altsd;
   635		int i, altno, err, stream;
   636		u64 format = 0;
   637		unsigned int num_channels = 0;
   638		struct audioformat *fp = NULL;
   639		int num, protocol, clock = 0;
   640		struct uac_format_type_i_continuous_descriptor *fmt;
   641		struct snd_pcm_chmap_elem *chmap_v3 = NULL;
   642		unsigned int chconfig;
   643	
   644		dev = chip->dev;
   645	
   646		/* parse the interface's altsettings */
   647		iface = usb_ifnum_to_if(dev, iface_no);
   648	
   649		num = iface->num_altsetting;
   650	
   651		/*
   652		 * Dallas DS4201 workaround: It presents 5 altsettings, but the last
   653		 * one misses syncpipe, and does not produce any sound.
   654		 */
   655		if (chip->usb_id == USB_ID(0x04fa, 0x4201))
   656			num = 4;
   657	
   658		for (i = 0; i < num; i++) {
   659			alts = &iface->altsetting[i];
   660			altsd = get_iface_desc(alts);
   661			protocol = altsd->bInterfaceProtocol;
   662			/* skip invalid one */
   663			if (((altsd->bInterfaceClass != USB_CLASS_AUDIO ||
   664			      (altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIOSTREAMING &&
   665			       altsd->bInterfaceSubClass != USB_SUBCLASS_VENDOR_SPEC)) &&
   666			     altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
   667			    altsd->bNumEndpoints < 1 ||
   668			    le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize) == 0)
   669				continue;
   670			/* must be isochronous */
   671			if ((get_endpoint(alts, 0)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) !=
   672			    USB_ENDPOINT_XFER_ISOC)
   673				continue;
   674			/* check direction */
   675			stream = (get_endpoint(alts, 0)->bEndpointAddress & USB_DIR_IN) ?
   676				SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
   677			altno = altsd->bAlternateSetting;
   678	
   679			if (snd_usb_apply_interface_quirk(chip, iface_no, altno))
   680				continue;
   681	
   682			/*
   683			 * Roland audio streaming interfaces are marked with protocols
   684			 * 0/1/2, but are UAC 1 compatible.
   685			 */
   686			if (USB_ID_VENDOR(chip->usb_id) == 0x0582 &&
   687			    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
   688			    protocol <= 2)
   689				protocol = UAC_VERSION_1;
   690	
   691			chconfig = 0;
   692			/* get audio formats */
   693			switch (protocol) {
   694			default:
   695				dev_dbg(&dev->dev, "%u:%d: unknown interface protocol %#02x, assuming v1\n",
   696					iface_no, altno, protocol);
   697				protocol = UAC_VERSION_1;
   698				/* fall through */
   699	
   700			case UAC_VERSION_1: {
   701				struct uac1_as_header_descriptor *as =
   702					snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
   703				struct uac_input_terminal_descriptor *iterm;
   704	
   705				if (!as) {
   706					dev_err(&dev->dev,
   707						"%u:%d : UAC_AS_GENERAL descriptor not found\n",
   708						iface_no, altno);
   709					continue;
   710				}
   711	
   712				if (as->bLength < sizeof(*as)) {
   713					dev_err(&dev->dev,
   714						"%u:%d : invalid UAC_AS_GENERAL desc\n",
   715						iface_no, altno);
   716					continue;
   717				}
   718	
   719				format = le16_to_cpu(as->wFormatTag); /* remember the format value */
   720	
   721				iterm = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
   722									       as->bTerminalLink);
   723				if (iterm) {
   724					num_channels = iterm->bNrChannels;
   725					chconfig = le16_to_cpu(iterm->wChannelConfig);
   726				}
   727	
   728				break;
   729			}
   730	
   731			case UAC_VERSION_2: {
   732				struct uac2_input_terminal_descriptor *input_term;
   733				struct uac2_output_terminal_descriptor *output_term;
   734				struct uac2_as_header_descriptor *as =
   735					snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
   736	
   737				if (!as) {
   738					dev_err(&dev->dev,
   739						"%u:%d : UAC_AS_GENERAL descriptor not found\n",
   740						iface_no, altno);
   741					continue;
   742				}
   743	
   744				if (as->bLength < sizeof(*as)) {
   745					dev_err(&dev->dev,
   746						"%u:%d : invalid UAC_AS_GENERAL desc\n",
   747						iface_no, altno);
   748					continue;
   749				}
   750	
   751				num_channels = as->bNrChannels;
   752				format = le32_to_cpu(as->bmFormats);
   753				chconfig = le32_to_cpu(as->bmChannelConfig);
   754	
   755				/* lookup the terminal associated to this interface
   756				 * to extract the clock */
   757				input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
   758										    as->bTerminalLink);
   759				if (input_term) {
   760					clock = input_term->bCSourceID;
   761					if (!chconfig && (num_channels == input_term->bNrChannels))
   762						chconfig = le32_to_cpu(input_term->bmChannelConfig);
   763					break;
   764				}
   765	
   766				output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
   767										      as->bTerminalLink);
   768				if (output_term) {
   769					clock = output_term->bCSourceID;
   770					break;
   771				}
   772	
   773				dev_err(&dev->dev,
   774					"%u:%d : bogus bTerminalLink %d\n",
   775					iface_no, altno, as->bTerminalLink);
   776				continue;
   777			}
   778	
   779			case UAC_VERSION_3: {
   780				struct uac3_input_terminal_descriptor *input_term;
   781				struct uac3_output_terminal_descriptor *output_term;
   782				struct uac3_as_header_descriptor *as;
   783				struct uac3_cluster_header_descriptor *cluster;
   784				struct uac3_hc_descriptor_header hc_header;
   785				u16 cluster_id, wLength;
   786	
   787				as = snd_usb_find_csint_desc(alts->extra,
   788								alts->extralen,
   789								NULL, UAC_AS_GENERAL);
   790	
   791				if (!as) {
   792					dev_err(&dev->dev,
   793						"%u:%d : UAC_AS_GENERAL descriptor not found\n",
   794						iface_no, altno);
   795					continue;
   796				}
   797	
   798				if (as->bLength < sizeof(*as)) {
   799					dev_err(&dev->dev,
   800						"%u:%d : invalid UAC_AS_GENERAL desc\n",
   801						iface_no, altno);
   802					continue;
   803				}
   804	
   805				cluster_id = le16_to_cpu(as->wClusterDescrID);
   806				if (!cluster_id) {
   807					dev_err(&dev->dev,
   808						"%u:%d : no cluster descriptor\n",
   809						iface_no, altno);
   810					continue;
   811				}
   812	
   813				/*
   814				 * Get number of channels and channel map through
   815				 * High Capability Cluster Descriptor
   816				 *
   817				 * First step: get High Capability header and
   818				 * read size of Cluster Descriptor
   819				 */
   820				err = snd_usb_ctl_msg(chip->dev,
   821						usb_rcvctrlpipe(chip->dev, 0),
   822						UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
   823						USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
   824						cluster_id,
   825						snd_usb_ctrl_intf(chip),
   826						&hc_header, sizeof(hc_header));
   827				if (err < 0)
   828					return err;
   829				else if (err != sizeof(hc_header)) {
   830					dev_err(&dev->dev,
   831						"%u:%d : can't get High Capability descriptor\n",
   832						iface_no, altno);
   833					return -EIO;
   834				}
   835	
   836				/*
   837				 * Second step: allocate needed amount of memory
   838				 * and request Cluster Descriptor
   839				 */
   840				wLength = le16_to_cpu(hc_header.wLength);
   841				cluster = kzalloc(wLength, GFP_KERNEL);
   842				if (!cluster)
   843					return -ENOMEM;
   844				err = snd_usb_ctl_msg(chip->dev,
   845						usb_rcvctrlpipe(chip->dev, 0),
   846						UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
   847						USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
   848						cluster_id,
   849						snd_usb_ctrl_intf(chip),
   850						cluster, wLength);
   851				if (err < 0) {
   852					kfree(cluster);
   853					return err;
   854				} else if (err != wLength) {
   855					dev_err(&dev->dev,
   856						"%u:%d : can't get Cluster Descriptor\n",
   857						iface_no, altno);
   858					kfree(cluster);
   859					return -EIO;
   860				}
   861	
   862				num_channels = cluster->bNrChannels;
   863				chmap_v3 = convert_chmap_v3(cluster);
   864	
   865				kfree(cluster);
   866	
   867				format = le64_to_cpu(as->bmFormats);
   868	
   869				/* lookup the terminal associated to this interface
   870				 * to extract the clock */
   871				input_term = snd_usb_find_input_terminal_descriptor(
   872								chip->ctrl_intf,
   873								as->bTerminalLink);
   874	
   875				if (input_term) {
   876					clock = input_term->bCSourceID;
   877					break;
   878				}
   879	
   880				output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
   881										      as->bTerminalLink);
   882				if (output_term) {
   883					clock = output_term->bCSourceID;
   884					break;
   885				}
   886	
   887				dev_err(&dev->dev,
   888					"%u:%d : bogus bTerminalLink %d\n",
   889					iface_no, altno, as->bTerminalLink);
   890				continue;
   891			}
   892			}
   893	
   894			if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
   895				/* get format type */
   896				fmt = snd_usb_find_csint_desc(alts->extra,
   897							      alts->extralen,
   898							      NULL, UAC_FORMAT_TYPE);
   899				if (!fmt) {
   900					dev_err(&dev->dev,
   901						"%u:%d : no UAC_FORMAT_TYPE desc\n",
   902						iface_no, altno);
   903					continue;
   904				}
   905				if (((protocol == UAC_VERSION_1) && (fmt->bLength < 8))
   906						|| ((protocol == UAC_VERSION_2) &&
   907								(fmt->bLength < 6))) {
   908					dev_err(&dev->dev,
   909						"%u:%d : invalid UAC_FORMAT_TYPE desc\n",
   910						iface_no, altno);
   911					continue;
   912				}
   913	
   914				/*
   915				 * Blue Microphones workaround: The last altsetting is
   916				 * identical with the previous one, except for a larger
   917				 * packet size, but is actually a mislabeled two-channel
   918				 * setting; ignore it.
   919				 */
   920				if (fmt->bNrChannels == 1 &&
   921				    fmt->bSubframeSize == 2 &&
   922				    altno == 2 && num == 3 &&
   923				    fp && fp->altsetting == 1 && fp->channels == 1 &&
   924				    fp->formats == SNDRV_PCM_FMTBIT_S16_LE &&
   925				    protocol == UAC_VERSION_1 &&
   926				    le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize) ==
   927								fp->maxpacksize * 2)
   928					continue;
   929			}
   930	
   931			fp = kzalloc(sizeof(*fp), GFP_KERNEL);
   932			if (!fp)
   933				return -ENOMEM;
   934	
   935			fp->iface = iface_no;
   936			fp->altsetting = altno;
   937			fp->altset_idx = i;
   938			fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
   939			fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
   940			fp->datainterval = snd_usb_parse_datainterval(chip, alts);
   941			fp->protocol = protocol;
   942			fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
   943			fp->channels = num_channels;
   944			if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
   945				fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
   946						* (fp->maxpacksize & 0x7ff);
   947			fp->attributes = parse_uac_endpoint_attributes(chip, alts, protocol, iface_no);
   948			fp->clock = clock;
   949			INIT_LIST_HEAD(&fp->list);
   950	
   951			/* some quirks for attributes here */
   952			snd_usb_audioformat_attributes_quirk(chip, fp, stream);
   953	
   954			/* ok, let's parse further... */
   955			if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
 > 956				if (snd_usb_parse_audio_format(chip, fp, format,
   957								fmt, stream) < 0) {
   958					kfree(fp->rate_table);
   959					kfree(fp);
   960					fp = NULL;
   961					continue;
   962				}
   963			} else {
   964				struct uac3_as_header_descriptor *as;
   965	
   966				as = snd_usb_find_csint_desc(alts->extra,
   967							     alts->extralen,
   968							     NULL, UAC_AS_GENERAL);
   969	
   970				if (snd_usb_parse_audio_format_v3(chip, fp, as,
   971									stream) < 0) {
   972					kfree(fp->rate_table);
   973					kfree(fp);
   974					fp = NULL;
   975					continue;
   976				}
   977			}
   978	
   979			/* Create chmap */
   980			if (fp->channels != num_channels)
   981				chconfig = 0;
   982	
   983			if (protocol == UAC_VERSION_3)
   984				fp->chmap = chmap_v3;
   985			else
   986				fp->chmap = convert_chmap(fp->channels, chconfig,
   987							  protocol);
   988	
   989			dev_dbg(&dev->dev, "%u:%d: add audio endpoint %#x\n", iface_no, altno, fp->endpoint);
   990			err = snd_usb_add_audio_stream(chip, stream, fp);
   991			if (err < 0) {
   992				list_del(&fp->list); /* unlink for avoiding double-free */
   993				kfree(fp->rate_table);
   994				kfree(fp->chmap);
   995				kfree(fp);
   996				return err;
   997			}
   998			/* try to set the interface... */
   999			usb_set_interface(chip->dev, iface_no, altno);
  1000			snd_usb_init_pitch(chip, iface_no, alts, fp);
  1001			snd_usb_init_sample_rate(chip, iface_no, alts, fp, fp->rate_max);
  1002		}
  1003		return 0;
  1004	}
  1005	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--k1lZvvs/B4yU6o8G
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k1lZvvs/B4yU6o8G--
