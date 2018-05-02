Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbeEBJTN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:19:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53888 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeEBJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:19:11 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180502091908euoutp01e335cf3a76ace65cfb95e33a55615bd9~qyUs87zvu3204232042euoutp01c
X-AuditID: cbfec7f4-b4fc79c0000043e4-c6-5ae9828b8ef0
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] thermal: exynos: fix trips limit checking in
 get_th_reg()
Date: Wed, 02 May 2018 11:19:06 +0200
Message-id: <2166794.yRDuDm3vze@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180501093914.GG27619@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djPc7rdTS+jDNZ907CY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvjQtcz9oJGjooT0xewNjAuZ+ti5OSQEDCRWLzoICuILSSwglHixEvzLkYuIPszo8TJ
        n80sMEUv+3+yQSSWMUocWjuVEaLjN6PE9PU2IDabgJXExPZVYHERAT2JxvdtTCANzAKrGCX6
        P71jAkkIC4RJnFjxEWw1i4CqxLsbj8BW8wpoSmyfNgesWVTAS2LLvnawek6g+MGl2xghagQl
        fky+B3YRs4C8xL79U1khbB2Js8fWMYIskxBYwSYxZW4DO8TZLhLXrh6A+lNY4tXxLVBxGYnL
        k7tZIBqaGSW+7djDDJGYwCixZ70QhG0tcfj4RagNfBKTtk0HquEAivNKdLRBlXhI7Gh5wARh
        O0rM2nWOHRIqtxglzi5wmMAoOwvJ3bOQ3D0Lyd0LGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al
        6yXn525iBCaE0/+Of9nBuOtP0iFGAQ5GJR5eg7wXUUKsiWXFlbmHGCU4mJVEeFd2PIsS4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzhunURclJJCeWJKanZpakFoEk2Xi4JRqYGy0mzEta4NYaEr2
        LjXzMK5jRtte/mgr7zmj93Fu9K5/lxueTO6LP9H57p3jGtPuJX9+h1y3/uZ2eB33OZ95m064
        Gc7f/eT7orWXXnFcNps4rfDJovrC2XXGst79qkGmaUWH4iRrLsoUdDTMrde9UjA3WX1d0x3B
        l4WL5DSvPPUVTumZMcfXdaYSS3FGoqEWc1FxIgCO4y9EBAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsVy+t/xq7rdTS+jDFbP4baY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvjQtcz9oJGjooT0xewNjAuZ+ti5OSQEDCReNn/E8jm4hASWMIoMe9AFwuE85dR4sne
        vawgVWwCVhIT21cxgtgiAnoSje/bmECKmAVWMUqsbO1lBkkIC4RJnFjxEWwsi4CqxLsbj8Ca
        eQU0JbZPmwPWLCrgJbFlXzsTiM0JFD+4dBsjxLY2RonzV6cyQTQISvyYfI8FxGYWkJfYt38q
        K4StJbF+53GmCYz8s5CUzUJSNgtJ2QJG5lWMIqmlxbnpucVGesWJucWleel6yfm5mxiBobvt
        2M8tOxi73gUfYhTgYFTi4TXIexElxJpYVlyZe4hRgoNZSYR3ZcezKCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK85w0qo4QE0hNLUrNTUwtSi2CyTBycUg2M0feuOrztCT3Rrbk78t3FaNeDIqcX
        2Ph/iHbhOv3y9qMDz3WP7agplaiaHfn0xZ6EJ1lbljxNrtNWvryJOaajZllXXadG7r1DolNm
        2J2VqHxwoWCy6sacpX8m3TR5Iqj45p+HVFXKcfWeE/viPZSet/Ox3JQJiru7OtF+X5bSjQhv
        puaTMxX8lFiKMxINtZiLihMB2xQJ5lkCAAA=
X-CMS-MailID: 20180502091907eucas1p17017c6793fb49f0c90660b3042b803bb
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502091907eucas1p17017c6793fb49f0c90660b3042b803bb
X-RootMTR: 20180502091907eucas1p17017c6793fb49f0c90660b3042b803bb
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <26762578.lZtk787caq@amdc3058> <20180501093914.GG27619@mai>
        <CGME20180502091907eucas1p17017c6793fb49f0c90660b3042b803bb@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 01, 2018 11:39:14 AM Daniel Lezcano wrote:
> On Mon, Apr 30, 2018 at 05:48:29PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Monday, April 30, 2018 05:34:31 PM Daniel Lezcano wrote:
> > > On Thu, Apr 26, 2018 at 01:51:21PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > of_thermal_get_ntrips() may return value bigger than supported
> > > > by a given SoC (i.e. on Exynos5422/5800) 
> > > 
> > > Can you elaborate a bit ?
> > 
> > Odroid-XU3 DTS file [1] define 6 thermal trip points (2 passive ones)
> > while data->ntrip is 4, the current code works fine by accident as
> > the threshold values for trip points 5 & 6 don't fit into 32-bits
> > threshold value (however since they are passive ones this is okay).
> 
> Ah, I see. data->ntrip is the SoC specific tmu max value capping what is
> defined in the DT, right ?

It is SoC specific max value for active + critical trips points.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
