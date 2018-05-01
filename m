Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeEAI4y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:56:54 -0400
Received: from omr-a012e.mx.aol.com ([204.29.186.61]:55781 "EHLO
        omr-a012e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeEAI4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:56:51 -0400
From: Gao Xiang <hsiangkao@aol.com>
Subject: workqueue: could work->func be reused for private data by introducing
 per-wq default function?
To: tj@kernel.org, jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org
Message-ID: <64a98b96-c3cc-ae20-30f6-04d7c6f9f113@aol.com>
Date: Tue, 1 May 2018 16:51:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
x-aol-global-disposition: G
x-aol-sid: 3039ac1afd4e5ae82a9126ec
X-AOL-IP: 112.65.13.67
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun Heo, Lai Jiangshan,


     I don't know whether the related topic was discussed or not (or 
it's actually an insane proposal :( )

     It seems that the most of workqueues INIT_WORK by a default handle 
function.

     So could we use a per-workqueue default handle function for these 
workqueues, and leave an extra private data field for each work_struct?

     There are so many work_structs that we could reuse the func field 
for the other uses.

     Is it acceptable? I haven't dived into the workqueue implementation 
yet, but it seems not straight-forward for find_worker_executing_work, 
etc. at a glance.


     Thanks,

Gao Xiang
