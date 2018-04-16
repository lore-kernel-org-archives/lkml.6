Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+mQTm+OeWzj8uXNx/ms6/NdWZM0hgGfcycgO3PahqPMboEjjxiZfTgPuKJ/i8p/8zvrAVf
ARC-Seal: i=1; a=rsa-sha256; t=1523889007; cv=none;
        d=google.com; s=arc-20160816;
        b=K492Qg3OQv8Bl0EaKtRkA+dDazGFfLBfhxWXV2ysL+W/UMqsCk8SrjfVEPvT/K2j9J
         URsFtN9CzIXzSyO4uf4KCImaHDlk3ALw+2vR40F7KkVjui5js3DcLP6Aoxrcavv5PNRf
         1GCJS76oTiXabPAen4FAKPYkdh+keZs2SpAhGcoh6uWTlwtWOE2ds1+PcSE4+PEfYOiC
         W3UHZrSbeNuk3ZFbCv6t/uI/BIx0BWBkvuYUq/h2bIqrNjgomxDYA+1KhPte2oqdTVXl
         qRgpl5Ec41AszE0un8Y8cPYSkt+GxhxBBe51GKnCPRG1+3bjIdp0nNnbvWlCvUVCr9BT
         YIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=dxDP2BzgPHof10QGtW/RcbSQZgsmbGO1bb08sW1rhtI=;
        b=TWSCQFzb5hT6YYN2XYj5lPeWIZOQgE2cqtEYseSF09jWTcgrpQNOdfTdIBjxaQ32JN
         PDw9iG0x0dbhBa9En+ubY0KfoLy6o+/BD5q9R1VexCCU+XbBkScJHyy27X9bulHAZgig
         ftkISbH762Gqy8pEDy897uDCbaUt78xc/mVPlPikbSNazzALVBXqks4U8+CdicNqM/dV
         DjG/hU0I5O06Ygz0+ozT6uLL5DgsSKkpxE4YzTuIYQny+ylSrNR1bFPuquirnnAqGdfp
         lJt+SNFjKp14fFJMeYNXm/A/wE/b6ZIYGPvbNIJwOiF67o9Z9gVhDWI7Su4/QW+iYWUs
         YKbA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dFllkS3Q;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WEZTJSBD;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dFllkS3Q;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WEZTJSBD;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A017B601E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v13 0/6] Address error and recovery for AER and DPC
To: Bjorn Helgaas <helgaas@kernel.org>, poza@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Timur Tabi <timur@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <20180416031600.GB80087@bhelgaas-glaptop.roam.corp.google.com>
 <5b4e667f-bead-a007-78dd-e42d3194f232@codeaurora.org>
 <9301606a70a213c180d9e6764b002cf9@codeaurora.org>
 <20180416132753.GA28657@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <91420f0f-31c1-0d82-63cc-627fb4920b6d@codeaurora.org>
Date: Mon, 16 Apr 2018 10:30:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416132753.GA28657@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027023020186?=
X-GMAIL-MSGID: =?utf-8?q?1597913439570698062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/16/2018 9:27 AM, Bjorn Helgaas wrote:
>>> We realized that DPC and hotplug is heavily integrated today. We
>>> have use cases for systems without hotplug support but still
>>> support DPC. That's the problem we are trying to solve with this
>>> patchset.
> Apparently there's a problem with systems that have DPC but not
> hotplug.  It will be extremely helpful if you can articulate what that
> problem is and include it in the appropriate changelog.
> 

At a higher level, the DPC driver performs the stop operation regardless of
hotplug. However, DPC driver relies on hotplug driver observing link up to
re-enumerate. 

Of course, when the system didn't support hotplug; there was nobody to
restore functionality.

Our initial attempt was to also do a re-enumeration in the DPC driver
regardless of hotplug driver in the system or not. 

If hotplug driver is present, it would observe two enumerations. It still
worked as long as these were protected by a mutex.

Then, we got your input that you want DPC and AER to behave the same. We
started converging towards the AER path.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
