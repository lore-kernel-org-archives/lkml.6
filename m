Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934660AbeE2NPy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:15:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:53819 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934505AbeE2NPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:15:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,456,1520924400";
   d="scan'208";a="60010029"
From: "Konopko, Igor J" <igor.j.konopko@intel.com>
To: Javier Gonzalez <javier@cnexlabs.com>,
        Matias Bjorling <mb@lightnvm.io>
CC: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>
Subject: RE: [GIT PULL 16/20] lightnvm: error handling when whole line is bad
Thread-Topic: [GIT PULL 16/20] lightnvm: error handling when whole line is
 bad
Thread-Index: AQHT9mMB+Jc5ev3KeUm1itfTxN3xpKRE6D2AgAHG44A=
Date: Tue, 29 May 2018 13:15:42 +0000
Message-ID: <76C92B909A93A84C99173B331AB578DAC7AB5252@irsmsx111.ger.corp.intel.com>
References: <20180528085841.26684-1-mb@lightnvm.io>
 <20180528085841.26684-17-mb@lightnvm.io>
 <C161E678-ADEE-4E05-AC19-B54358005532@cnexlabs.com>
In-Reply-To: <C161E678-ADEE-4E05-AC19-B54358005532@cnexlabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDdiYzQ5ZWYtYzIyZi00MDg5LTg0ZjEtYmY5MmYxOGM0ZmEyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVTFYQTBjeFd2U3hFcWNmZkp5WW9lM3pPXC85RjdqYTZuN1lpNERvNmNWUjc5d2pcL1BqTkJSWHBweXlMSXhGMVcrIn0=
x-ctpclassification: CTP_NT
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4TDFwDM024770

> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
> This case cannot occur on the only user of the function
> (pblk_recov_l2p()). On the previous check (pblk_line_was_written()), we
> verify the state of the line and the position of the first good chunk. In
> the case of a bad line (less chunks than a given threshold to allow
> emeta), the recovery will not be carried out in the line.
You are right. It looks that during my testing there was some inconsistency between chunks state table which is verified inside pblk_line_was_written() and blk_bitmap which was read from emeta and is verified in pblk_line_smeta_start(). I'm living decision to maintainers whether we should keep this sanity check or not - it really just pass gracefully the result from pblk_line_smeta_start() where similar sanity check is present.

Igor
