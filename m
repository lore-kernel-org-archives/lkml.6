Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49FUKgEUH0KUkHDDAEhfCx/Ldmg7BGipfTdVmPbHbrYIxtCHLBJOs5UiztqVXmLEqJEvYVE
ARC-Seal: i=1; a=rsa-sha256; t=1523455994; cv=none;
        d=google.com; s=arc-20160816;
        b=sU6KeEjNJAUf09SQAxAVk5VzhnF6dAvN0YSHPu2mEyiAHU2c5BWGCzy6qKJG8YCbH0
         9KXaVPbmSlB5PKeBFF5w6+ca99qX7CwpBxFEX8htfte9j4W5l1DtO088S7glZWWAtSQn
         VbWnjI/FGOtqGiv+O2PAdfuS5Xh/rwO7dCt3rG8meosBXUKXk5Sk5jA1r7Qrvtre0tWd
         9Is4FBuqCSalQJ3OnRSDPu3kRn9aahjlPMXvnllO/kGXlVhDgGGq1ynkv7fi4aL+iQJ+
         0MGeuB3KOBwzll01eOj8gW+/KI+clH3lMVqtsyRWZfeMRy6Kdl7p86xgzT+ER7XUSbez
         hKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=iyPv16gF3rUZfNawSK3jcnffrPwjFoSNn89Y9OcjsVg=;
        b=LfwF4iAfodpLOM0rMjzjVVDQSzVypcbcD0c+GxV7xEUYrZRQP1XbuW2z9uF0Qq+UMq
         k5Qi+52XKcNF0q9P1C9KM3ELG+nXkqFpfrhHF7YaflrT7umubrZda8ia0xURWnyhKACj
         FoU5zTMVrECt6Bwle/jwABCK4XnT9D7FD3QVxMBCitckXIdKRYeNpbd8EAwNRSvpUx5z
         zMeLsAm3LbfV0gvU/HyVsczCtvCbQum4N5BtmWU+ulRjlpWcR2vxrGN5feaWXUhpxkyt
         xqCJz5SXiqhd8oDAhUNRbYgx9mxrTUqM40d9hEmzfuIEA+rtCPZvBrP+LFTpbOGh93FP
         RrSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VeP49VWw;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jFrS/rdy;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VeP49VWw;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jFrS/rdy;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F9EB607EF
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
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <1290e3d3-e7f0-a4f5-925d-2b7c2cb42b93@codeaurora.org>
Date: Wed, 11 Apr 2018 10:13:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411140849.GA12557@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597458696879800529?=
X-GMAIL-MSGID: =?utf-8?q?1597459392220369322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/11/2018 10:08 AM, Greg Kroah-Hartman wrote:
>>> So I added these stable tags:
>>>
>>>   CC: stable@vger.kernel.org      # v4.11: 62ce94a7a5a5 PCI: Mark Broadcom HT2100 Root Port Extended Tags as broken
>>>   CC: stable@vger.kernel.org      # v4.11
>>>
>>> I'm not sure I'm using the stable request correctly, but my intent is:

Asking if we placed the tags correctly. Sounds like we did.

>>>
>>>   - 62ce94a7a5a5 appeared in v4.14, so cherry-pick 62ce94a7a5a5 to
>>>     v4.11 through v4.13
>>>   - cherry-pick *this* patch on top of 62ce94a7a5a5 to v4.11 and later
> Bjorn is correct here, why are you dragging me into this?

Thanks

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
