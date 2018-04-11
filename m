Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+6G/u6/JKC9ZT0CjUXZEYYgLwZGaEyBdiSuyXj9BjYF77uCPEqqsxZWYMeL+cPiltDXbKr
ARC-Seal: i=1; a=rsa-sha256; t=1523463821; cv=none;
        d=google.com; s=arc-20160816;
        b=CVVMrTMpK2kckCj4bOFhruviO0bnxvO9th8nKfkWSkm3lk/LQlPF9GMEz1Sa+oT4eI
         k2qPEXzVBkPeh3mol3sILYYSWaD0mW3MjiplP7uoAun82ZVomfj2wWeYUAArS97xtCWl
         XDDQK1eWD8jCZDqgsODO2zYwQFNQljXO7vBD9M/d5mBBAscMrai16ZOZR4oCWRXy1V9K
         P5RwgB9GoimfbFEWEHRmdi8sTTNgeh+/BpHO5JZmZ5P4BgPHyRb1BBOT25C3k0IPR5LR
         k0ekLsMNfHn1xtxKI6QbHQYXAw9L4kiPL92i3NAioDM+13Nn2qSQuV+yXHcDXu+E4bb8
         Ax9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=7rwtCcjsgkn0UfCjyxlzZv6IBKMBDD6/suCqZADeV4Q=;
        b=l5tDmpZM69P8DQBaACe/nyJ7kwyPe5fpHckwh2jnfdPrp7WT8WX8Q0f+2w8j2+62HP
         7Ul4nMDsoaEUaho7KPrAiCNF73m1Eo5Tt9x2JpyzM7+5DZC1onwYJiomLnMSsU/8tWWv
         sIFOpJRzIVAcUsQKpOZcNObcKOWEDbv+xzaDZ2ZyzwexLW4TafZ/IQB0oU2UzqGk+AT9
         n80Q8RUapYz2ban3/F0oU1zTyfiz3m4BWU8Q3l9dk/y1KadV1GQmgLOp3Jg2fh2PeXRn
         b9qgufw2ZyEB60EDEW5enTX1vvztz3NXOSCr1inmLxefqK+Hq9JOUzmh0TgdR2+qTUsN
         yf2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nPb34/Lx;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nPb34/Lx;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nPb34/Lx;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nPb34/Lx;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FD4F6081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] PCI: quirk HT1100 & HT2000 and one HT2100 Root Ports for
 Extended Tags
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 sulrich@codeaurora.org, timur@codeaurora.org, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, open list
 <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
References: <1522882209-9743-1-git-send-email-okaya@codeaurora.org>
 <20180410194144.GD54986@bhelgaas-glaptop.roam.corp.google.com>
 <20180410195008.GE54986@bhelgaas-glaptop.roam.corp.google.com>
 <1c94361d-7a8d-ad18-12e5-1612326a54db@codeaurora.org>
 <20180411135151.GB91792@bhelgaas-glaptop.roam.corp.google.com>
 <ecdad8f4-6996-cfe0-d005-fbc67ba3cd79@codeaurora.org>
 <20180411140849.GA12557@kroah.com>
 <1290e3d3-e7f0-a4f5-925d-2b7c2cb42b93@codeaurora.org>
 <20180411141922.GA13832@kroah.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d7b78270-c3ff-8c88-1ac0-f9467fb54da2@codeaurora.org>
Date: Wed, 11 Apr 2018 12:23:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411141922.GA13832@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597458696879800529?=
X-GMAIL-MSGID: =?utf-8?q?1597467599498460251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/11/2018 10:19 AM, Greg Kroah-Hartman wrote:
> Next time explicitly ask the question, don't expect someone to rummage
> through an email to determine what you are thinking.  You are being lazy
> by just adding someone else to an email thread like this, be considerate
> and take the time to explain yourself when asking someone else to do
> work.

Sorry, I should have stripped irrelevant pieces like you said.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
