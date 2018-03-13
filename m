Return-Path: <kernel-hardening-return-12561-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELts9X9f/7e3OP6Cl++/9WpIpz0A6TE1K0NxKuq/VPZcF78/xZ/VR3WO17kZEW5aT59GmaWq
ARC-Seal: i=1; a=rsa-sha256; t=1520978465; cv=none;
        d=google.com; s=arc-20160816;
        b=T4AFXBmFDkzx2ZOF+9czU4nbsIW3hkhVIDn1BPvJbi1joS1OoeHxWSZzN+8dbnV1NX
         UWcmGy+oa7l+FWVO+kZgeKaJHYEq6P5T0kqcmZhBODwFL6nfn54IdWP1tofdcwBPVG6S
         Zi7BKdUsD2o3CCA4vy15daVe/p9avCXqnN1InO3EDcXvMtYvpcwWN8i3LLa200OvPk44
         sFsGVBw//jbaXwPUTyxl5DQ9sUMdE5LhGv8o4LULafSGCCho+s5E1eToey4T/zJZSuXV
         N8M0LRjyLreBqwygCfIYEQOv6h0I3KcBeMl7bTRtVxG+4iiDYHkw77DhQ6Ans0KuWzeS
         1vuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=GhvFeZrqEdgv0ONoZG35l+di61oDUMPfpQXNgbwPbeI=;
        b=Y2Mo3XCNN9po7o4gSoYlYFWpJVXVB0utfuJyjhHxN7av+z1/ppELzYj+ZgoiPPDDXj
         f0MOoQ/1NcT8L9uPqsgU4sEhLhAy2gXn4A7sUu2MxQSnmYTPIkgrbxDfldwA2cs6xvRs
         t//YncjDwfpB/afrqUOMPamSnISaC/GFOV0r1MKXhyHR3uhiyyTP/BRs7ElTe2+b7sjA
         gvOFVLZyvjRYhKcDYFjBaTD9j66kIqw4hzHru6eVMc2dJ45oZ2mOXgj8I3/7N2xSQmeO
         CiFDJrtQiZDnI8KWuusUZGo6xL9uNVm6L5URAsKFay7foCHHN85RT7QinPM/4BQWdxkj
         mgxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=P216EFkh;
       spf=pass (google.com: domain of kernel-hardening-return-12561-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12561-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=P216EFkh;
       spf=pass (google.com: domain of kernel-hardening-return-12561-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12561-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 13 Mar 2018 15:00:40 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: david@fromorbit.com, rppt@linux.vnet.ibm.com, keescook@chromium.org,
	mhocko@kernel.org, labbott@redhat.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 4/8] struct page: add field for vm_struct
Message-ID: <20180313220040.GA15791@bombadil.infradead.org>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <20180313214554.28521-5-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313214554.28521-5-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860882497845479?=
X-GMAIL-MSGID: =?utf-8?q?1594861515913167109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 11:45:50PM +0200, Igor Stoppa wrote:
> When a page is used for virtual memory, it is often necessary to obtain
> a handler to the corresponding vm_struct, which refers to the virtually
> continuous area generated when invoking vmalloc.
> 
> The struct page has a "mapping" field, which can be re-used, to store a
> pointer to the parent area.
> 
> This will avoid more expensive searches, later on.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Regardless of the fate of the rest of this patchset, this makes sense
and we should have this.
