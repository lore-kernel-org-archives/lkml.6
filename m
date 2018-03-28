Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeC1OFp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:05:45 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40530 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbeC1OFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:05:43 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180328140541epoutp0138201cb197ce606d0ca8f42341faaab5~gGp5R3gww3131331313epoutp01p
X-AuditID: b6c32a48-8c1ff70000000ff2-70-5abba134e53a
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        "'SF Markus Elfring'" <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] video: s3c-fb: Improve a size determination in
 s3c_fb_probe()
Date: Wed, 28 Mar 2018 16:05:30 +0200
Message-id: <2206589.7tfjgjbFvn@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <000301d367aa$8efbbc40$acf334c0$@gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7bCmqa7Jwt1RBv+XKltc+fqezeJ853Jm
        ixVfZrJbbL0lbXGi7wOrxeVdc9gc2Dx2zrrL7nG/+ziTR9OpdlaPz5vkAliiuGxSUnMyy1KL
        9O0SuDJmtu1mKljIVnHhgG4DYytrFyMnh4SAicTcRYcYQWwhgR2MEuePu3YxcgHZ3xklTmyY
        xwRTNPXEXyaIxG5GiburZrNCOF8ZJRqnXgNrZxOwkpjYvgrMFhGIkTiwfipYN7NAF6PE4ykW
        ILawQITEpfMLweIsAqoSH35eYgOxeQU0Jfa9PcQMYosKeEls2dcOVsMpYCFx/tw9dogaQYkf
        k++xQMyUl9i3fyorhK0jcfbYOkaQgyQENrBJ9L56AXW2i8SE2RvZIGxhiVfHt7BD2NISz1Zt
        hGpoZpT4tmMPM0RiAqPEnvVCELa1xOHjF6E28El0HP4L1MwBFOeV6GiDKvGQuLX7DguE7Six
        YvoNaKicYpR409bBPIFRdhaSw2chOXwWksMXMDKvYhRLLSjOTU8tNiow0StOzC0uzUvXS87P
        3cQITgdaHjsYD5zzOcQowMGoxMNbELMrSog1say4MvcQowQHs5II73uN3VFCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEedsCXKKEBNITS1KzU1MLUotgskwcnFINjPZaDS13JPLebFswv3xPqd2z
        9XPSDoT5Tt60YV58/LU5Qb9/puUUh0SL9C9ifLBp2r9lnCXbkqc4zSzWOK1rWrD5/rK9+/Qu
        Zlw7xnlqqkPYw9P64YqVn3Qy2xQUFrDd2LVJtZHn25MPVSvUpJXrWSyWRXzQZxOdOfXs4vkS
        5u3G/rd2GcTEWCuxFGckGmoxFxUnAgAJpSwzAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jAV3jhbujDLYd17S48vU9m8X5zuXM
        Fiu+zGS32HpL2uJE3wdWi8u75rA5sHnsnHWX3eN+93Emj6ZT7awenzfJBbBEcdmkpOZklqUW
        6dslcGXMbNvNVLCQreLCAd0GxlbWLkZODgkBE4mpJ/4ydTFycQgJ7GSUmNmxjg3C+coosfb5
        KbAqNgEriYntqxhBbBGBGInVi9eCdTALdDFKXP6+FKxIWCBC4tL5hUwgNouAqsSHn5fYQGxe
        AU2JfW8PMYPYogJeElv2tYPVcApYSJw/d48dxBYSOMUoceJlMkS9oMSPyfdYQGxmAXmJffun
        skLYWhLrdx5nmsDIPwtJ2SwkZbOQlC1gZF7FKJlaUJybnltsVGCUl1quV5yYW1yal66XnJ+7
        iREYwNsOa/XvYHy8JP4QowAHoxIPb0HMrigh1sSy4srcQ4wSHMxKIrzvNXZHCfGmJFZWpRbl
        xxeV5qQWH2KU5mBREuflzz8WKSSQnliSmp2aWpBaBJNl4uCUamDc+ajyw9J05Z8p52ceY27R
        md8iN3/bryfTb9ks1dBeuKvRSbdN43+kxfu4uRNjXH/vmnV+dbUj/6klQkun1876lyvnq7U+
        LN96gdu+pccmeqZuO+wlZX9Q48mbuTf2LznKsXhDI9ft4AkXs1RLcmpNjhyRnLXx0orOyN/1
        624xWGx9Oadk0rKDPkosxRmJhlrMRcWJALl5gu5cAgAA
X-CMS-MailID: 20180328140539epcas2p4ce1ee067510b2bf51b8ad4839fea4511
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171127180721epcas2p1549ab6d72f7d83ff7eb5276079037b26
X-RootMTR: 20171127180721epcas2p1549ab6d72f7d83ff7eb5276079037b26
References: <2c837da0-6b0f-12e7-4d76-960b660a8911@users.sourceforge.net>
        <CGME20171127180721epcas2p1549ab6d72f7d83ff7eb5276079037b26@epcas2p1.samsung.com>
        <000301d367aa$8efbbc40$acf334c0$@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 27, 2017 01:07:15 PM Jingoo Han wrote:
> On Sunday, November 26, 2017 9:18 AM, SF Markus Elfring wrote:
> > 
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sun, 26 Nov 2017 15:03:03 +0100
> > 
> > Replace the specification of a data structure by a pointer dereference
> > as the parameter for the operator "sizeof" to make the corresponding size
> > determination a bit safer according to the Linux coding style convention.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
