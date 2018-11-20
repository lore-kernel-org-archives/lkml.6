Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FE8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194DE20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194DE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbeKTMre convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:47:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:31636 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbeKTMrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:47:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 18:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,255,1539673200"; 
   d="scan'208";a="101615967"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2018 18:20:50 -0800
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 19 Nov 2018 18:20:50 -0800
Received: from orsmsx105.amr.corp.intel.com ([169.254.2.237]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.106]) with mapi id 14.03.0415.000;
 Mon, 19 Nov 2018 18:20:50 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Pavel Machek <pavel@ucw.cz>, "Moger, Babu" <Babu.Moger@amd.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v7 00/13] arch/x86: AMD QoS support
Thread-Topic: [PATCH v7 00/13] arch/x86: AMD QoS support
Thread-Index: AQHUeG4dJz0szErVIk6LNqmmQKnpf6VYXLuA//+g3bA=
Date:   Tue, 20 Nov 2018 02:20:49 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C71220985A75CE@ORSMSX105.amr.corp.intel.com>
References: <20181109205153.14811-1-babu.moger@amd.com>
 <20181119235817.GA4763@amd>
In-Reply-To: <20181119235817.GA4763@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWZjMDFlNGQtYTE0OS00YjkwLWFiNWYtNmZlNDdiODFiYzA3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibnhURlwvWjBkZitCaWlmYjY5TlZIVzlEVW83SExmUnF6Z0lNaGhwVmNabVZpeU9naVQ3a1RJVEhwXC93ZWlEV3Y1In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@ucw.cz]
> >  rename Documentation/x86/{intel_rdt_ui.txt => resctrl_ui.txt} (99%)
> 
> Rest of files in that directory use - as a separator; and maybe qos.txt would
> be a better name then this?

Actually a few other files in the directory use "_" as a separator (e.g. intel_mpx.txt etc). "qos.txt" is not a good name because we want to use a generic file name. So "resctrl_ui.txt" should a good name AFAIK.

Thanks.

-Fenghua
