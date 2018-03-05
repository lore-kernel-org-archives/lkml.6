Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AG47ELupDzy2p6UhiOxSBctlUAN0JFDuxZDiIbRfX2mcSgx362rwUwBM6ApZUMs1IZ/j1tCtFWbs
ARC-Seal: i=1; a=rsa-sha256; t=1520264917; cv=none;
        d=google.com; s=arc-20160816;
        b=q4AB5J4CmYUJ6+6ZvudIIaBSHl1mY9cYzzq1UrqeRoruJO0mPQZIjVgNbs07xIbYpV
         R+5KBS2y6KDCWRLhJzcm7eaPVFWfo2xvFZIx59yfTAqlyE7NTJWbG6jjqNWlOshwoCGr
         I8vZR6tNxiRNHS3EwCyMiVIA7uzioCiSLKzOzkRilYFxHVSyaIbzt4mXMltyw9QkNJ8h
         qQ84VEV70TURfFXA5H5aPRmBDgxwFreB6XMVo4PEick98RliDUnquweCIERUGj3zFLNS
         gccKSPqvsd/RuVo2ObI6R7K9baQ9JQWSsy7k6BTgRbAvYHMj65i6Nr4ve8IG9gd8j3e8
         3MnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=ZRrbmiH86GRnpvqsvkwqU7zJSEHrbmfW67NDdypYpPI=;
        b=gTIUvymowxkWoGTeK9l2VHwOC4bL4CswH7uoAoIaWuDWc3KPkkWltY5rD5ikc8rtg3
         Pk8EsgQMlmXWcndMFvFRaRRWZT24KFDguEBX7TRRrLR7PfNz4sncwZd7NxrcALFOPPbn
         7nxk+PIoPjCoZ1OdG+CVpYMRtq6K3TCzGjoZPB282cU0OuPSpXDqr0M/R6qFSiwFL3ia
         U1lsgiFMo1tyZ7KAa8+wqncGOAWaZSqqLgGlqmIgZ1Y+PEtytxl7GbOOAt5DXx+bUcBr
         40FVJSUKkn/DfhaxKoy17dEKs3Lhe/tyx6QtskxucJoTVbtoNdxEXINmiFGhr4ci4TFR
         gyBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH 5/6] dma-mapping: support fsl-mc bus
To: Christoph Hellwig <hch@lst.de>
Cc: Nipun Gupta <nipun.gupta@nxp.com>, will.deacon@arm.com,
 mark.rutland@arm.com, catalin.marinas@arm.com,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 m.szyprowski@samsung.com, gregkh@linuxfoundation.org, joro@8bytes.org,
 leoyang.li@nxp.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, bharat.bhushan@nxp.com, stuyoder@gmail.com,
 laurentiu.tudor@nxp.com
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
Date: Mon, 5 Mar 2018 15:48:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305150814.GA15918@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108392554438818?=
X-GMAIL-MSGID: =?utf-8?q?1594113306082117264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/03/18 15:08, Christoph Hellwig wrote:
> We should not add any new hardocded busses here.  Please mark them in
> OF/ACPI.

Unfortunately for us, fsl-mc is conceptually rather like PCI in that 
it's software-discoverable and the only thing described in DT is the bus 
"host", thus we need the same sort of thing as for PCI to map from the 
child devices back to the bus root in order to find the appropriate 
firmware node. Worse than PCI, though, we wouldn't even have the option 
of describing child devices statically in firmware at all, since it's 
actually one of these runtime-configurable "build your own network 
accelerator" hardware pools where userspace gets to create and destroy 
"devices" as it likes.

Robin.
