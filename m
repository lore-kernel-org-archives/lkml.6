Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2880798-1521467698-2-11519183236531965276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: .config.gz
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521467698; b=oBXS2k9uteZyZG8e4tGyw9YeffkaovoWgAKfk/XLqM2Ee/6
    f2p0qFFJtZ2ym47iJx/dLQro8+0f34kYQqNTxZtxhX9JduyMqgGUdqJAxEqvv93A
    yUnBLcyFxPP/1akqAgLrWIkNZFyf95GTjzyvtJ6jBc/Kbl68hYxGZbczcdINdQmT
    h7UeNSNPF1gfBldgWIvnVR/BK1zVZah82gB9NIUsWwc0wD6NmlShgg0Xz4okNLO6
    YWuJ8xbQjpd1AEIpYPgUlBPmDT6kKB+QMM4inZrKP9S7VA/ffmzIuA1XJ/s/cAQs
    VoPJ2Q/MNRY5vsnqh+3APYsb3wDEKJ6bx1kCLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521467698; bh=o/baO6oI1Q4AZ3xd7fWNGpCCOm
    AaLmMaszJz+kT4xPs=; b=VP9zrL7if9IarN2QaPFwJmtTZqQFRQ7XlNAo44RG4h
    98sHsGevecQNjtd7VwPzlxVNc2LxFTyfDuVITrN0RPvByEbP3OsGtvDrDgreix5P
    /X+YFKhR8Hf9ZbP2D6WouSFa6jdIvSS0IoZnRYdrpHkqXQoRoo4gXOYGbctMGHP2
    7e7kQNCh9eH/0hC2DSfGrjlC4mV5vaAnixUf9ZTseJtJ+SDaKLUUKciYL7CWp5RU
    4PrAz0hLmSRoUdhLUL0fxi0QBcZ3GkivNBsguj9Y7TuUzlA757edybKWK5AlsJuk
    TAnlxte0LNXKjfne2EK+u6obz0aoLPMqx30o3HSKaalg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdehheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehmtderredtredvnecuhfhrohhmpehksghuihhlugcuthgvshhtuchrohgsohhtuceolhhkphesihhnthgvlhdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdptddurdhorhhgpdhgnhhurdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpudelvddrheehrdehvddrgeefnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdhushgsqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegieelhedvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdehheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehmtderredtredvnecuhfhrohhmpehksghuihhlugcuthgvshhtuchrohgsohhtuceolhhkphesihhnthgvlhdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdptddurdhorhhgpdhgnhhurdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpudelvddrheehrdehvddrgeefnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdhushgsqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegieelhedvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeCSNyU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 09:54:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:40395 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932277AbeCSNyR (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 19 Mar 2018 09:54:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,330,1517904000";
   d="gz'50?scan'50,208,50";a="25225880"
Date: Mon, 19 Mar 2018 21:53:16 +0800
From: kbuild test robot <lkp@intel.com>
To: Daniel Drake <drake@endlessm.com>
Cc: kbuild-all@01.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, chiu@endlessm.com, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] ACPI / PM: allow deeper wakeup power states with no _SxD
 nor _SxW
Message-ID: <201803192119.WIzt6M4j%fengguang.wu@intel.com>
References: <20180319072941.22767-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20180319072941.22767-1-drake@endlessm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180319]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Daniel-Drake/ACPI-PM-allow-deeper-wakeup-power-states-with-no-_SxD-nor-_SxW/20180319-185209
config: i386-randconfig-x074-201811 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/acpi/device_pm.c: In function 'acpi_dev_pm_get_state':
>> drivers/acpi/device_pm.c:607:7: warning: 'sxd_status' may be used uninitialized in this function [-Wmaybe-uninitialized]
       if (sxd_status == AE_OK && target_state > ACPI_STATE_S0)
          ^

vim +/sxd_status +607 drivers/acpi/device_pm.c

   516	
   517	/**
   518	 * acpi_dev_pm_get_state - Get preferred power state of ACPI device.
   519	 * @dev: Device whose preferred target power state to return.
   520	 * @adev: ACPI device node corresponding to @dev.
   521	 * @target_state: System state to match the resultant device state.
   522	 * @d_min_p: Location to store the highest power state available to the device.
   523	 * @d_max_p: Location to store the lowest power state available to the device.
   524	 *
   525	 * Find the lowest power (highest number) and highest power (lowest number) ACPI
   526	 * device power states that the device can be in while the system is in the
   527	 * state represented by @target_state.  Store the integer numbers representing
   528	 * those stats in the memory locations pointed to by @d_max_p and @d_min_p,
   529	 * respectively.
   530	 *
   531	 * Callers must ensure that @dev and @adev are valid pointers and that @adev
   532	 * actually corresponds to @dev before using this function.
   533	 *
   534	 * Returns 0 on success or -ENODATA when one of the ACPI methods fails or
   535	 * returns a value that doesn't make sense.  The memory locations pointed to by
   536	 * @d_max_p and @d_min_p are only modified on success.
   537	 */
   538	static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
   539					 u32 target_state, int *d_min_p, int *d_max_p)
   540	{
   541		char method[] = { '_', 'S', '0' + target_state, 'D', '\0' };
   542		acpi_handle handle = adev->handle;
   543		unsigned long long ret;
   544		int d_min, d_max;
   545		bool wakeup = false;
   546		acpi_status sxd_status;
   547		acpi_status status;
   548	
   549		/*
   550		 * If the system state is S0, the lowest power state the device can be
   551		 * in is D3cold, unless the device has _S0W and is supposed to signal
   552		 * wakeup, in which case the return value of _S0W has to be used as the
   553		 * lowest power state available to the device.
   554		 */
   555		d_min = ACPI_STATE_D0;
   556		d_max = ACPI_STATE_D3_COLD;
   557	
   558		/*
   559		 * If present, _SxD methods return the minimum D-state (highest power
   560		 * state) we can use for the corresponding S-states.  Otherwise, the
   561		 * minimum D-state is D0 (ACPI 3.x).
   562		 */
   563		if (target_state > ACPI_STATE_S0) {
   564			/*
   565			 * We rely on acpi_evaluate_integer() not clobbering the integer
   566			 * provided if AE_NOT_FOUND is returned.
   567			 */
   568			ret = d_min;
   569			sxd_status = acpi_evaluate_integer(handle, method, NULL, &ret);
   570			if ((ACPI_FAILURE(sxd_status) && sxd_status != AE_NOT_FOUND)
   571			    || ret > ACPI_STATE_D3_COLD)
   572				return -ENODATA;
   573	
   574			/*
   575			 * We need to handle legacy systems where D3hot and D3cold are
   576			 * the same and 3 is returned in both cases, so fall back to
   577			 * D3cold if D3hot is not a valid state.
   578			 */
   579			if (!adev->power.states[ret].flags.valid) {
   580				if (ret == ACPI_STATE_D3_HOT)
   581					ret = ACPI_STATE_D3_COLD;
   582				else
   583					return -ENODATA;
   584			}
   585			d_min = ret;
   586			wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
   587				&& adev->wakeup.sleep_state >= target_state;
   588		} else {
   589			wakeup = adev->wakeup.flags.valid;
   590		}
   591	
   592		/*
   593		 * If _PRW says we can wake up the system from the target sleep state,
   594		 * the D-state returned by _SxD is sufficient for that (we assume a
   595		 * wakeup-aware driver if wake is set).  Still, if _SxW exists
   596		 * (ACPI 3.x), it should return the maximum (lowest power) D-state that
   597		 * can wake the system.  _S0W may be valid, too.
   598		 */
   599		if (wakeup) {
   600			method[3] = 'W';
   601			status = acpi_evaluate_integer(handle, method, NULL, &ret);
   602			if (status == AE_NOT_FOUND) {
   603				/* No _SxW. In this case, the ACPI spec says that we
   604				 * must not go into any power state deeper than the
   605				 * value returned from _SxD.
   606				 */
 > 607				if (sxd_status == AE_OK && target_state > ACPI_STATE_S0)
   608					d_max = d_min;
   609			} else if (ACPI_SUCCESS(status) && ret <= ACPI_STATE_D3_COLD) {
   610				/* Fall back to D3cold if ret is not a valid state. */
   611				if (!adev->power.states[ret].flags.valid)
   612					ret = ACPI_STATE_D3_COLD;
   613	
   614				d_max = ret > d_min ? ret : d_min;
   615			} else {
   616				return -ENODATA;
   617			}
   618		}
   619	
   620		if (d_min_p)
   621			*d_min_p = d_min;
   622	
   623		if (d_max_p)
   624			*d_max_p = d_max;
   625	
   626		return 0;
   627	}
   628	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--cWoXeonUoKmBZSoM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--cWoXeonUoKmBZSoM--
