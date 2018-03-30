Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AIpwx48CI+5mhFw+4PfanVLaNR/xsXcDyLjwGdfjeIPiZHQ+zcPcXLWgrNOMtf60NsCL13r3/hk9
ARC-Seal: i=1; a=rsa-sha256; t=1522376134; cv=none;
        d=google.com; s=arc-20160816;
        b=PRo2FxZPahEckl0g57DBSMQAacNT7ear8WJB19oaSuZtcaIbFe6CMdm2R5XIiEYzre
         FhSz/kSqffs5WMCWkNmS/TQTnBXbbJSn0/weeafAtWZF7CNaFSj49YyTLUf0Hkmt8Flz
         TGrM2fsFMFwf+r7Mcdpf/B3PjY1tjjgEURUIL/AoqcKN5AfWbMEHBEZoVN8gxllUfAhl
         NLBjkY1oXFKWQO5X7IoF/1OUfs5+Xo1Jikk4tfqjKPSCPoSufL8sr2nl75xpgXwafxOs
         QSJGCP62BkHB6nyE9QugSEwUA0vGVLyH06pxwRizRcQ7YXpn6WoH01R/e9t7sq3J/ARK
         fwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ruLVdU3oTZjKJ1mP5viQtykmbH9WadXsBV9s0LVNMw8=;
        b=NT5lpSSXYvafJLyZAPkQ6TFNRo2Il3sXBfw2DECiR+WWshGW4zPpiDpZfsfvwcvjZH
         68j8ItOXnm2Pm0VIwf7qGa2VNYwHpXPlo9A6W8EWRxI2p5fku7FMESP/H1AZ+pCohAE6
         6P7NOR2jiajoROUpEtAMMqGamxSZHr7/igyZ6kEj5WjpkIuxlbLjZFlphcIKk4eGk2UJ
         pBU1a6bePeX01dkeGtckWtuu266vzBOEcQ+IvM2c4FgrfshZGtFhMFtO3z4ZqdK1v+L6
         ORtoboVdQ6AiFmJAEs3MaOz0bMM/wwm7wnW2vWMl3jVWCaks+6rki7jI08LJWkR6bdqC
         WHMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="38047988"
Date: Fri, 30 Mar 2018 10:15:30 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Minchan Kim <minchan@kernel.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
	LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
	Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v3] ANDROID: binder: change down_write to down_read
Message-ID: <20180330021530.iisqrcuw4uoohvv4@wfg-t540p.sh.intel.com>
References: <20180329023712.133164-1-minchan@kernel.org>
 <201803300705.KbdKYZ01%fengguang.wu@intel.com>
 <20180330003736.GA255979@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180330003736.GA255979@rodete-desktop-imager.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596231778699320743?=
X-GMAIL-MSGID: =?utf-8?q?1596327077808752110?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 09:37:36AM +0900, Minchan Kim wrote:
>On Fri, Mar 30, 2018 at 07:42:37AM +0800, kbuild test robot wrote:
>> Hi Minchan,
>>
>> I love your patch! Yet something to improve:
>
>Glad to hear.
>It's first time someone loves my patch. ;-)

FYI, that message originates from Linus. :-)

>> [auto build test ERROR on staging/staging-testing]
>> [also build test ERROR on v4.16-rc7 next-20180329]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Minchan-Kim/ANDROID-binder-change-down_write-to-down_read/20180330-043057
>> config: x86_64-randconfig-x014-201812 (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers//android/binder.c: In function 'binder_mmap':
>> >> drivers//android/binder.c:4725:24: error: 'struct vm_area_struct' has no member named 'flags'; did you mean 'vm_flags'?
>>      vma->vm_flags = (vma->flags | VM_DONTCOPY | VM_MIXEDMAP) &
>>                            ^~~~~
>>                            vm_flags
>
>http://lkml.kernel.org/r/<20180329065424.203172-1-minchan@kernel.org>
>
>This time, I was little bit fast. :)

Hurrah, quick hands! :)

Cheers,
Fengguang
