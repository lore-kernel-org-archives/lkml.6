Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AIpwx4/yKtz+S9wuepQj1UWZrvojaY9uNNZ78xrxY6r2JvBTn4JRASu8OgZlUioBz63Z8vCko6Tv
ARC-Seal: i=1; a=rsa-sha256; t=1524545263; cv=none;
        d=google.com; s=arc-20160816;
        b=rvvgRu04qCDYjMm0P0CtWNm000jRKpHz5mB+1BVhojY/SA3HiDVQs3Gp+FDgPpzCjw
         O54bqbjz5+fxoip+ePFBezydb/s1Ztp7EBteGCoBi/7duWU003Dk61Nx+0CZkQkbo3Gi
         W1ZFYo3/c40fgw30mbMClCbjPtXBxU4hK2BeCEE1xZzy+0zZ0jFCAARK8fbLLc7B42zI
         OGKCc3ExuUh1uM3sPT7MX0QKrtlkQCIRc+uyiCUxbBDmb9GWpLD1Tka40bpY5G1Yh++N
         aYwye/HV3TNxG/Wat1nMNF/khBjzuKjoDftcw4yLk3/WElQMPgROFu8KaaZzyHwxb29S
         qU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=uLAX3fIrXtkeTZEZxwGtEa4mtS91SYYD4oyFxsM8G+U=;
        b=PjeH2PtCz+AZFo9fy5HxyByFu4HThr8G6zG7E7MxbV+bpjOaHgPWZhdLO6M/BsWXJY
         aE1MUWAWoXpitC9Obt3/yq+5NdS1M8FDI9v7WSkwZ/wWp4n5rSmhLtzx86DD0gJQjg74
         9o1As0k2NnRXSq4n9xDAUBnkwpKzg4QfHGh/bE+AL7jJ/FzmrdwtJ2vXXKcXwXLhjLtQ
         kcmkWS48t/hMWguJg/6Hbr+wXP1u0wOg1w/IWmPGj487lf9Koj5geihnm2g3NOM1PvVN
         Xd3eeyztlvqCSN4DhfW9TQhdUstHsFvE2Egauy3G/lb1wAcc0b+c9189xTqYAlqj73jb
         kXVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,321,1520924400";
   d="scan'208";a="53141660"
Date: Tue, 24 Apr 2018 12:47:34 +0800
From: kbuild test robot <lkp@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>,
	Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH v14 8/9] PCI/AER/DPC: Align FATAL error handling for AER
 and DPC
Message-ID: <201804241214.r7shZqom%fengguang.wu@intel.com>
References: <1524496993-29799-9-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524496993-29799-9-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550965105099560?=
X-GMAIL-MSGID: =?utf-8?q?1598601574823186116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Oza,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.16]
[cannot apply to pci/next linus/master v4.17-rc1 next-20180423]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oza-Pawandeep/Address-error-and-recovery-for-AER-and-DPC/20180424-090411
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/pcie/err.c:276:18: sparse: symbol 'pcie_do_fatal_recovery' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
