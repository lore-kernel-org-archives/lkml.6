Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963EDC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5542B20672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="3lpwXmDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5542B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeLLXGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:06:37 -0500
Received: from cmta18.telus.net ([209.171.16.91]:60097 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbeLLXGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:06:36 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id XDaKgx6kKiBO5XDaLgWVjh; Wed, 12 Dec 2018 16:06:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1544655995; bh=A6sRBMfO3IwSBN/EOo27nCYnJ4SE/L+u593WIJNBa4Y=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=3lpwXmDAtTEQFKQW5qJRaOElfLvxawHAAeRApN2+5mNrXaOY++I2anI5sAcMxZpC+
         31JzN0/5WJA/NDX8p4GZtRsuhlNNGsn6KqnhRQKXhvQDxhlNWJi7G8aj+M5ZkimM4J
         p5IgiDBp0NoHX0d/m3vhDJ8nX8uAgvov4SnjGy8oYkny5Eo7flUI/o+4MaOZDegYd3
         TrtjUmykcb1v3c9Z9whM0egyKv7MlHvdw8Gxvcrdzp+2csOYkKCydfPcFEs9pazNIH
         QzBCAiHGPDPf/Wa/4TkU1zJb2Aga6TiZSyud8CvxoA+Ho0ZyogS3FLeFXSUcO/t3iI
         LZPnpRt71bj7Q==
X-Authority-Analysis: v=2.3 cv=d5AkNirE c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=O_trBvZXBQXvV-bKK-cA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Paul Menzel'" <pmenzel@molgen.mpg.de>
Cc:     <linux-pm@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Len Brown'" <lenb@kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: XCF0g8mvUQvFWXCF1gj1RM
In-Reply-To: XCF0g8mvUQvFWXCF1gj1RM
Subject: RE: intel_pstate: Lowest frequency not reached with Intel i7-6700
Date:   Wed, 12 Dec 2018 15:06:30 -0800
Message-ID: <000701d4926f$533eb270$f9bc1750$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdSSY0xL7OYJgTiHSHOhB+La+iB2zgACm1CA
X-CMAE-Envelope: MS4wfJnJSdnrzAYRUeUdQxe7QVFZQ/9B4Bmz4ASRloJKD1zAFMnvJ0D9YheWJx2e5W9NwJ2MCPpSFvpyGTqBlaYlnOie50pLOpuadOudYvfCci7E5uAnejmL
 jTeoqGsNTqndtDbREiFu8aiTRVYpxiv7ztRtmF6EBT546J5tGchAz0IOn5eCJRlVBKaEYe6V6efZTju0U0cpmE9mSQv8OBhyTDj36ExQBqeb4OfnG0J2Ozj0
 4mUpyBJdKRiD1VpGysn4EUvGaXJ362WvsQ3rxzPF4HQO6iguAOO/4dgd4IabzRp1eYLSAVwk1HSGIWMiNF6y6EVPrDGaz8iNRtUvfcTZpFxynzs4cxOOFdhP
 dsisO0qw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.12.12 13:40 Paul Menzel wrote:

> Using *powersave* as P-state selection algorithm, on an idle system

Define "idle system".
If your computer is running a GUI, or is even a server without a GUI
but with many services running, then "idle" really isn't.
Below is from my test server, with many services disabled, so
"idle" really is quite "idle"

doug@s15:~/temp$ sudo turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt --interval 15
Busy%   Bzy_MHz PkgTmp  PkgWatt
0.01    1608    27      3.71
0.01    1619    27      3.71
0.01    1600    28      3.71
0.01    1600    28      3.70

Note that p state 16 (1600 MHz) is the minimum for my older i7-2600k =
processor.

> Shouldn=E2=80=99t it go down until 800 MHz?

We would need some actual busy information, turbostat is the recommended =
tool,
to know for sure.

... Doug


