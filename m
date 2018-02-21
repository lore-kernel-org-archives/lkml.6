Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933161AbeBUQSJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:18:09 -0500
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:58046 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966324AbeBUQSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:18:05 -0500
Date: Wed, 21 Feb 2018 10:09:53 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Shakeel Butt <shakeelb@google.com>
cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Directed kmem charging
In-Reply-To: <20180221030101.221206-1-shakeelb@google.com>
Message-ID: <alpine.DEB.2.20.1802211002200.12567@nuc-kabylake>
References: <20180221030101.221206-1-shakeelb@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfAn6aueZ7lWeCrwh3VaSdzjrx10qQ8RmPIEhnO1HrHp9JsPrEVeuOK6xCDsahTxrs0b2sovcAFGCcX+XzPPjgXRx1FXB0snVCsPNcr7MCs7nyhT+L5lC
 k4s3tY6QQ3jgtx3y/IrYwcIUTxf4JslwJIFuF51ESN73InB3YnG/SwBOa8jUswq0S4FJG3yy+bMG6b4tEw5nsD9bWq/oTaeYODY2/B09KA/LzT1/VnEpcwjh
 ciJMme4okzfbBtnKFcRry9/UquxkJVps3JkJDtaTkvbLT6+elI2zzoV2ygfI2nim748OvF3P0l24kEMzNty1ZcHllFXoiY/uyIkze1AXLzQ+hkmv8hopbuVg
 qv2NWesHu1EFTv5esPyll5QrhBp4lQVo+oY9cMV20DsP9hEXXZj09fqX5LH9xw/7xBipuKl3O2mXgx4rbc6SewfvFu85lRjAaolhkHdd52B/n440sEh1VL/o
 i9qqhZcRTxTusSsieWNFeaM+roipfl6pFcIRos5NIAx2EvfdGlXo1r1Ok2Dl02RrykAPZ+NEVbocqah8HKP2xqLmlQDTQ2IH74CX456AvwLnmuCw8EhDkUop
 7YGxNueDyab92fXqPhhd/J5I4DKXf95TsGaVJIZ1ix2q5qIIIFyKImQ91YKn5oA5+Bo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another way to solve this is to switch the user context right?

Isnt it possible to avoid these patches if do the allocation in another
task context instead?

Are there really any other use cases beyond fsnotify?


The charging of the memory works on a per page level but the allocation
occur from the same page for multiple tasks that may be running on a
system. So how relevant is this for other small objects?

Seems that if you do a large amount of allocations for the same purpose
your chance of accounting it to the right memcg increases. But this is a
game of chance.
