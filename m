Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031272AbeBNVOD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:14:03 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:33679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030501AbeBNVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:14:02 -0500
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Enrico Weigelt <lkml@metux.net>
Subject: fs_struct refcounting: spinlock vs atomic
Organization: metux IT consult
Message-ID: <7547a9ed-a2e7-e975-a3ba-f41abc16f4bc@metux.net>
Date: Wed, 14 Feb 2018 22:13:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:SFcOOyf2m5mnay7ZnIl0O1T4Cz1st7yvgRIng163wvoOeJigK3U
 qcbRyy6r1oa6TGN6iDTdnKPFpF8RNWUg6UtfmIIWkD7snPsH0O2BeaXs7qgJAFB89bD3RVp
 904hMJ4PKQzOfiSumhWxoAb+SgedCncdR805r+GcMNbwJiPEwj1LZnrn6oanzaavp8x8w4a
 CF9vV2rvSF2PfZ0rBcadw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ffClgBCp7B0=:jeDUyEFKtqjQQSffP7OuLh
 iQvGEeyBDHyzATvKEZNrB88HXJEvA+II1I3aFLo6pu7T0HOG1CWJV297igvJYMg1GqMJMlJBn
 DZ1iBV7IHMef0nVyTHYUp6W1x2wUiv9VidHJ/E3ET8T2MGLZT/otoTGtE8rT2ssBrqpb0rmtx
 wfERO2zFNpq7QW2+jYwU1/1tQetIy9D4yg+LiibLvLySYn5h84opRpaZcuFDTEUPt9FWX9h6F
 a5lR/jA6X2MeMCDnafuJBDQY9gT0AjrheB+n7Tz2jdVm5co5g4/vxzRkdBQnK6uM3dpFjB/b5
 SAV1vn2InuzTWmeXjjAIErtiuxRpC+H8IwR/M1d0Er62MRSx1fQ6aVCoSAYDvApu5hzVWwxTJ
 yroGlzsC1Uo6wgk7839rRC1aUCoRxXZc9xYj3fCIn9ZJiYruAaZbHqoGTJmVoJIIW6sJGe02D
 BJjpxfJdVfbYodXkwx7F2lOt9k2bvHu20Td4wbxpX2dVDUQzYRiRJlN5+pthN6Vl/MwFWZczQ
 FPx1PqZjKQZtkRnunrEa0g4N6kz94XQtN/sKjaoNsqIUZNeVC4Wir5j4cw8WX3e+1KZCbThZm
 XzN1fgijxT/6sf3q0MukU8+BcRqKbP+c1qsQS2b1m78ihZX06jgRzHZwb8ldZB7u5z6AQFtfS
 J0xV9qPy93nvitHUJi3uyS3QRWTOD4kTJIEoGhpwG9HRsowa7QTDGBbOCpxaacAWQHoNIyXEB
 UaZBQ9HKxWD2Uy1CHr01L3xIlfl6oGtSppYXF2t8ZzyG3PdvIvUbPXKrAvQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


in fork.c, a spinlock is held for fs_struct refcounting, while other
places - eg. switch_task_namespaces uses atomic_dec_and_test() on
the nsproxy.

What's the exact difference here ? Could the atomic counting also used
for fs_struct ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
