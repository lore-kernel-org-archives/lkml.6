Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AB8JxZr14J9EANnKPs6p4XS7J2oi15iMOOejAP2M36zzhy6/ETWP4jC5ovqrsNxTKZ8sRpX594xQ
ARC-Seal: i=1; a=rsa-sha256; t=1525571842; cv=none;
        d=google.com; s=arc-20160816;
        b=gkaD3lo5t4yEAF1+r5MCCRVDRgMEjA4zK58lRPd+wq+yTjEQlBcW5b9zDTF9sU3CCl
         /8N5F2N+eINxP81qaMfUjSP4wbDzQHHl9Xe0HXlOagoJSisl19nLe7vB8DD2vuDqastB
         fJhRMw5BrcB5fD51K/pKU90wydYFT17Grlz18KvvnZcNtXLg5U9uL0eXjhSBTvrCnrXn
         5t408R91zgpfQEBEAto6nB2AbhlLGH2rIDxpYh98egn+Bu/vjSZ5yZDCeVkH9fCz1Kjx
         58YD0ImNNgQTue0G8jjJMfFH6gl5+zx1t0TdnrZCcykqd/JT7K7PDeL4NBJjSglvbyYM
         GoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=OgmuYVjXqTyjqdFmPh2QXflhdmiQIY2w6ki7FgtPGcU=;
        b=h6bnWwmrCUhLfdBy9g4+M/pIeOEKDeJ+HNwF8ucyhQsT7QSgSHVeFa6ojiwRQ5x2S9
         u1abtQCcSM7Hv+hJ50IaA98Ruswv2O6A7VNSYnyrbGPE1LHS95a4MXwl81EoHXTtzGT2
         Rt5bxIpZ4bkdkC/GSBEJWt0hVuaEg/xGQyK2XZE6SZULdiDBQfm3SINrGrjcQXm7MOZY
         veTQtFH+ZPOEc5ioT6dgLnbs9DTReF6XkjMJ7AXBA4emGg/x3MBx5dnL/PAVeoU+ZJ9T
         uhkzKjj023ofer2/ZmR6saJaxtJSkQB468hmpgoHMOlsBy3tijcCtrDOu7TmthNHn33N
         r2iA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,367,1520924400";
   d="scan'208";a="47049912"
Date: Sun, 6 May 2018 09:56:33 +0800
From: kbuild test robot <lkp@intel.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: kbuild-all@01.org, pasha.tatashin@oracle.com, steven.sistare@oracle.com,
	daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
	jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, gregkh@linuxfoundation.org,
	alexander.duyck@gmail.com, tobin@apporbit.com
Subject: Re: [Intel-wired-lan] [PATCH v2 1/1] drivers core: multi-threading
 device shutdown
Message-ID: <201805060956.WLlHt6Gx%fengguang.wu@intel.com>
References: <20180505154040.28614-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505154040.28614-2-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599639232732130480?=
X-GMAIL-MSGID: =?utf-8?q?1599678020319123177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Pavel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on v4.17-rc3 next-20180504]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pavel-Tatashin/multi-threading-device-shutdown/20180506-035150
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/base/core.c:2877:25: sparse: symbol 'device_root_tasks_done' was not declared. Should it be static?
   drivers/base/core.c:62:5: sparse: context imbalance in 'device_links_read_lock' - wrong count at exit
   drivers/base/core.c:67:6: sparse: context imbalance in 'device_links_read_unlock' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
