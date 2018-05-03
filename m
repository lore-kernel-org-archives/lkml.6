Return-Path: <morten.rasmussen@arm.com>
X-Google-Smtp-Source: AB8JxZoMAtVGYVTWrKpohjheU4QTx4r3ofpNnw/dVJ9kSJyKL1TxFoK0SQBxk6T9ZekpJu+1C60k
ARC-Seal: i=1; a=rsa-sha256; t=1525360520; cv=none;
        d=google.com; s=arc-20160816;
        b=vsIvVyUdti4x4ttG2Mvb+CWrw6p2Mk8ZHIl4pdondo58cCOcOMKKsZajJinPDdf/gR
         VPoOCmkWEaTAEn9QAV0bfiSwj2bBjjp8oDg2eIS+ePS7hat96oZp3L+zHafo1CmoxRxu
         jB1CDwqt++ksvxgO4kp5xe+icMSVN6140iwLnyxihMjTc26lFDAZUeqE2NFRfrlEeUtW
         vFaf2ws5mn8kbDx7oHXM/2FlS6I2J87lfmlNmBBI/3YgDqeYzet5NKdNlbK/RfiJWWkd
         3Lh7gTTlXtFhhKHt3QzHwIU8Rg0/w70FOcjpmHKQF7+nj1UNCEu3hxUJEbMPtkt8yRY6
         XoOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=hxQcsW1CBdBoX1y0tVPKu42c26AgRl1HO4xmFUaEHYI=;
        b=he+bvVtjvszDcXyeT8tbQs5RqVQ3d+1IsOrUWhUQIgT7alJbElAlpThVrhXF+puWHY
         ZowVpoeFrCbQzRNu86iWdmShG1m0ggQFLthVJnSCxT0dw5hu6NosGPIGMl7+PMo7tyy3
         xDxUMQQZtp7q9hu0brswpSUry7kYp0qb3c1wrJyhNe4IWCj4UyEHgRQlIxAyCHCTan9l
         bYc42Mm9SpHsnsWhtHmnIX+JWxMfQSaU0MehKdqr03V/nt5an7NI21riS4gIn9Y+Gw8O
         aZ2X+iWPq6pIRhkcuJSgPzT82viYia/clG0L3Mc6ILX5CRfbcTrdaO37O4x8UEWEH4Wj
         P9+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Date: Thu, 3 May 2018 16:15:13 +0100
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
	Catalin.Marinas@arm.com, gregkh@linuxfoundation.org,
	Mark.Rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org, ahs3@redhat.com, Dietmar.Eggemann@arm.com,
	palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com,
	austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
	jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
	ard.biesheuvel@linaro.org
Subject: Re: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU
 topology
Message-ID: <20180503151513.GD28409@work-enc>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-12-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425233121.13270-12-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766328036390506?=
X-GMAIL-MSGID: =?utf-8?q?1599456432411217659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 06:31:19PM -0500, Jeremy Linton wrote:
> Propagate the topology information from the PPTT tree to the
> cpu_topology array. We can get the thread id and core_id by assuming
> certain levels of the PPTT tree correspond to those concepts.
> The package_id is flagged in the tree and can be found by calling
> find_acpi_cpu_topology_package() which terminates
> its search when it finds an ACPI node flagged as the physical
> package. If the tree doesn't contain enough levels to represent
> all of the requested levels then the root node will be returned
> for all subsequent levels.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Acked-by: Morten Rasmussen <morten.rasmussen@arm.com>
