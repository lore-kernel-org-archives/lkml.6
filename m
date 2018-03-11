Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeCKNCH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 09:02:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932129AbeCKNCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 09:02:05 -0400
To: LKML <linux-kernel@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>, viro@zeniv.linux.org.uk
From: Zdenek Kabelac <zkabelac@redhat.com>
Subject: Timing performance regression 4.15 to 4.16-rc1
Organization: Red Hat
Message-ID: <31a4b0d7-2c9e-ce76-a486-48ed18b96cc6@redhat.com>
Date: Sun, 11 Mar 2018 14:02:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've noticed quite some drop of performance (around 15% in some cases) where 
execution of lvm2 tests took longer time - and while tests itself should not 
really load CPU system  - the overall running time just got bigger.

Running bisect game pointed clearly to this commit:

---

commit 44c02a2c3dc55835e9f0d8ef73966406cd805001
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Oct 5 12:59:44 2017 -0400

     dev_ioctl(): move copyin/copyout to callers


---

clear revert of this commit on top of 3266b5bd97eaa72793df0b6e5a106c69ccc166c4
(recent  ~4.16-rc4)  restored timing of tests back.


I'm not sure why - so at this moment this is just a patch causing 15% longer 
running times on lvm2 test suite.


Regards

Zdenek
