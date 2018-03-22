Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCVQf0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:35:26 -0400
Received: from smtp-out4.electric.net ([192.162.216.183]:50387 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeCVQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:35:23 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Laurent Dufour'" <ldufour@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
CC: Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/8] mm: mmap: unmap large mapping by section
Thread-Topic: [RFC PATCH 1/8] mm: mmap: unmap large mapping by section
Thread-Index: AQHTwfsLnX+N9Wjp+0uBZsFtdYSo/qPccqlQ
Date: Thu, 22 Mar 2018 16:36:14 +0000
Message-ID: <fd5c7272f19442828fb00dff7cb24fae@AcuMS.aculab.com>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
 <1521581486-99134-2-git-send-email-yang.shi@linux.alibaba.com>
 <20180321131449.GN23100@dhcp22.suse.cz>
 <8e0ded7b-4be4-fa25-f40c-d3116a6db4db@linux.alibaba.com>
 <cf87ade4-5a5c-3919-0fc6-acc40e12659b@linux.alibaba.com>
 <20180321212355.GR23100@dhcp22.suse.cz>
 <952dcae2-a73e-0726-3cc5-9b6a63b417b7@linux.alibaba.com>
 <20180322091008.GZ23100@dhcp22.suse.cz>
 <8b4407dd-78f6-2f6f-3f45-ddb8a2d805c8@linux.alibaba.com>
 <20180322161316.GD28468@bombadil.infradead.org>
 <e36daca9-8bf0-5fad-d68b-a3116cc1a75e@linux.vnet.ibm.com>
In-Reply-To: <e36daca9-8bf0-5fad-d68b-a3116cc1a75e@linux.vnet.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MGZSFj005751

From:  Laurent Dufour
> Sent: 22 March 2018 16:29
...
> This being said, having a per VMA lock could lead to tricky dead lock case,
> when merging multiple VMA happens in parallel since multiple VMA will have to
> be locked at the same time, grabbing those lock in a fine order will be required.

You could have a global lock and per VMA locks.
Anything that only accesses one VMA could release the global lock after
acquiring the per VMA lock.
If code needs multiple VMA 'locked' it can lock and unlock each VMA
in turn, then keep the global lock held.

	David
