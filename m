Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F09AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5C420825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fY93G84b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5C420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeKJAoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:44:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35724 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeKJAoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:44:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA9Ewwnt167247;
        Fri, 9 Nov 2018 15:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2018-07-02;
 bh=AfihBu6eud3kiaqurB8+6BVjEGYmi+kjZh7w+795dsE=;
 b=fY93G84b/UsyUaB+wSeZQcGNbbm40reqYUnFIoObVDj5bpArZcAeg5nM80WKDETtVhw2
 glHdOuVhxHXl6LhbTV6pn+lCs0pMW6G9jHKv9+xm/WkyXV3wKb3RZnGHZmej+yJusEQU
 +6O0+ennB1Lpo+zSxNDw8MsywiI8WjgmUd6bwytN95XxS4OaYnnb5fZGpv1C9C57NqN5
 w17TgDB/81mk/k+2oLK+E4zEgRJqiD/Y4Z5aDLSoDbBILd7ciKffZ6T3uMVjXfzziEzA
 cEY5aRpJoRqo+KZ+M7ji9d+F+HHGY+XkzYiH94a6aB6CWfUlUdp8FqC/rG1g3QL64cHL Hw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nh4ar7dt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 15:02:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA9F2niB002435
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 15:02:49 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA9F2m32001923;
        Fri, 9 Nov 2018 15:02:48 GMT
Received: from [10.39.236.216] (/10.39.236.216)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 07:02:48 -0800
From:   Steven Sistare <steven.sistare@oracle.com>
Subject: hackbench run scripts
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, linux-kernel@vger.kernel.org
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <0eaa3ee9-64d6-4739-eec9-e28befa0e97f@oracle.com>
Date:   Fri, 9 Nov 2018 10:02:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------C9659C45CF4A425E9F292B2F"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C9659C45CF4A425E9F292B2F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi folks,
  I am attaching the bash helper scripts I used to run and post-process hackbench
in case you find them useful.  They compute the statistics and print a nicely
formatted result:

  feat - Enable/disable one or more sched_features.
  runmany - run a command many times and print average time and stdev.
  hackdiff - Print difference between 2 identical series of runmany hackbench runs.

You supply the top level script that runs a series of groups.  Example:

---- hackseries ---------------
#!/bin/sh

iters=50000
groups="1 2 3 4"
runs=5

tmpfile=temp$$.out
rm -f $tmpfile

runall() {
    for g in $groups ; do
        echo hackbench $g process $iters | tee -a $tmpfile
        runmany $runs hackbench $g process $iters | tee -a $tmpfile
    done
}

sudo feat NO_STEAL ; runall ; echo
sudo feat STEAL    ; runall ; echo
hackdiff < $tmpfile
rm -f $tmpfile
--------------------------------

$ hackseries
hackbench 1 process 50000
 4.096  4.090  4.073  4.129  4.092     Average 4.096   stdev 0.5%
hackbench 2 process 50000
 7.215  7.214  7.242  7.208  7.224     Average 7.220   stdev 0.2%
hackbench 3 process 50000
10.082 10.035 10.049 10.068 10.082     Average 10.063   stdev 0.2%
hackbench 4 process 50000
12.851 12.948 12.905 12.916 12.994     Average 12.922   stdev 0.4%

hackbench 1 process 50000
 3.193  3.261  3.257  3.223  3.247     Average 3.236   stdev 0.9%
hackbench 2 process 50000
 6.020  5.960  6.003  6.008  5.998     Average 5.997   stdev 0.4%
hackbench 3 process 50000
 8.598  8.692  8.536  8.661  8.468     Average 8.591   stdev 1.1%
hackbench 4 process 50000
11.201 11.148 11.053 11.174 11.127     Average 11.140   stdev 0.5%

          --- base --    --- new ---
groups    time %stdev    time %stdev  %speedup
     1   4.096    0.5   3.236    0.9      26.5
     2   7.220    0.2   5.997    0.4      20.3
     3  10.063    0.2   8.591    1.1      17.1
     4  12.922    0.4  11.140    0.5      15.9

- Steve

--------------C9659C45CF4A425E9F292B2F
Content-Type: text/plain; charset=UTF-8;
 name="feat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="feat"

IyEvYmluL3NoCiMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKIyAKIyBBdXRo
b3I6IFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+CiMKIyBVc2Fn
ZTogZmVhdCBbZmVhdHVyZTFdIFtmZWF0dXJlMl0gLi4uCiMgICBFbmFibGUvZGlzYWJsZSBv
bmUgb3IgbW9yZSBzY2hlZF9mZWF0dXJlcy4KIyAgIFdpdGggbm8gYXJndW1lbnRzLCBwcmlu
dCB0aGUgY3VycmVudGx5IGVuYWJsZWQgZmVhdHVyZXMuCgppZiBbWyAhIC1yIC9zeXMva2Vy
bmVsL2RlYnVnIF1dOyB0aGVuCiAgICAgICAgZWNobyAiUGVybWlzc2lvbiBkZW5pZWQuIFlv
dSBtdXN0IGJlIHJvb3QuIgogICAgICAgIGV4aXQgMQplbGlmIFtbICEgLXIgL3N5cy9rZXJu
ZWwvZGVidWcvc2NoZWRfZmVhdHVyZXMgXV07IHRoZW4KICAgICAgICBlY2hvICJkZWJ1Z2Zz
IG5vdCBtb3VudGVkLiAgUGxlYXNlIHJ1biBhcyByb290OiIKICAgICAgICBlY2hvICIgICAg
bW91bnQgLXQgZGVidWdmcyBub25lIC9zeXMva2VybmVsL2RlYnVnIgogICAgICAgIGV4aXQg
MQpmaQoKaWYgWyAkIyA9PSAwIF0gOyB0aGVuCiAgICAgICAgY2F0IC9zeXMva2VybmVsL2Rl
YnVnL3NjaGVkX2ZlYXR1cmVzIHwgc2VkICdzLyAvXG4vZycKZWxzZQogICAgICAgIGZvciBm
ZWF0IGluICQqIDsgZG8KICAgICAgICAgICAgICAgIGlmICEgZWNobyAkZmVhdCA+IC9zeXMv
a2VybmVsL2RlYnVnL3NjaGVkX2ZlYXR1cmVzIDsgdGhlbgogICAgICAgICAgICAgICAgICAg
ICAgICBlY2hvIFVucmVjb2duaXplZCBmZWF0dXJlICRmZWF0CiAgICAgICAgICAgICAgICBm
aQogICAgICAgIGRvbmUKZmkKCmV4aXQgMAo=
--------------C9659C45CF4A425E9F292B2F
Content-Type: text/plain; charset=UTF-8;
 name="runmany"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="runmany"

IyEvYmluL3NoCiMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKIwojIEF1dGhv
cjogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4KIwojIFVzYWdl
OiBydW5tYW55IDxyZXBlYXQ+IGNvbW1hbmQgYXJncyAuLi4KIyAgIFJ1biBjb21tYW5kIDxy
ZXBlYXQ+IHRpbWVzLCBleHRyYWN0IHRpbWUsIGFuZCBwcmludCBhdmVyYWdlIGFuZCBzdGRl
di4KIwojIENvbW1hbmQgbXVzdCBwcmludCBhIGxpbmUgb2YgdGhlIGZvcm0gIlRpbWUgJWYi
IChlZywgbGlrZSBoYWNrYmVuY2gpLgoKCiMgQ29udmVydCBmbG9hdCAkMSB0byBpbnRlZ3Jh
bCBmaXhlZC1wb2ludCB2YWx1ZSB3aXRoICQyIGRlY2ltYWwgcGxhY2VzLgojCmZ0b2koKQp7
CglkZWNsYXJlIC1pIHRlbnM9MTAqKiQyCgllY2hvICQoZWNobyAic2NhbGU9MDsgKCR0ZW5z
ICogJDEpIC8gMSIgfCBiYyAtcSkKfQoKIyBDb252ZXJ0IGludGVncmFsIGZpeGVkLXBvaW50
ICQxIHdpdGggJDIgZGVjaW1hbCBwbGFjZXMgdG8gZmxvYXRpbmcgCiMgcG9pbnQgc3RyaW5n
LgojCml0b2YoKQp7CglkZWNsYXJlIC1pIGkgZnJhYyB0ZW5zIHg9JDEKCVtbICR4IC1sdCAw
IF1dICYmIHNpZ249Jy0nIHg9KC0keCkKCXRlbnM9MTAqKiQyCglpPSR4L3RlbnMKCWZyYWM9
JHgldGVucwoJcHJpbnRmICIlcyVkLiUwJHsyfWQiICIkc2lnbiIgJGkgJGZyYWMKfQoKIyBS
ZXR1cm4gdGhlIGF2ZXJhZ2Ugb2YgYWxsIGFyZ3VtZW50cy4KIwphdmVyYWdlKCkKewogICAg
ICAgIGRlY2xhcmUgLWkgeCBhdmc9MAoKCWZvciB4IGluICQqIDsgZG8KICAgICAgICAgICAg
ICAgIGF2Zz1hdmcreAogICAgICAgIGRvbmUKICAgICAgICBhdmc9YXZnLyQjCiAgICAgICAg
ZWNobyAkYXZnCn0KCiMgUmV0dXJuIHRoZSBzdGRldiBvZiBhbGwgYXJncywgYXMgYSBwZXJj
ZW50IG9mIHRoZSBhdmVyYWdlLCBhcyBhIGZsb2F0IHdpdGgKIyA2IGRlY2ltYWwgcGxhY2Vz
LgojCnN0ZGV2KCkKewogICAgICAgIGRlY2xhcmUgLWkgeCB2YXI9MAogICAgICAgIGRlY2xh
cmUgLWkgYXZnPSQoYXZlcmFnZSAkQCkKCglmb3IgeCBpbiAkKiA7IGRvCiAgICAgICAgICAg
ICAgICB4PXgtYXZnCiAgICAgICAgICAgICAgICB2YXI9dmFyK3gqeAogICAgICAgIGRvbmUK
ICAgICAgICBlY2hvICJzY2FsZT02OyBzcXJ0KCR2YXIgLyAoJCMgLSAxKSkgKiAxMDAgLyAk
YXZnIiB8IGJjIC1xCn0KCmRlY2xhcmUgLWkgbj0kMQpkZWNsYXJlIC1hIC1pIHQKCmlmIFtb
ICRuIC1lcSAwIF1dIDsgdGhlbgoJZWNobyAidXNhZ2U6IHJ1bm1hbnkgbnVtIGNvbW1hbmQg
YXJncyAuLi4iCglleGl0IDEKZmkKCmNtZD0iJHtAOjI6JCN9IgoKZm9yICgoaT0wOyBpPCRu
OyBpPWkrMSkpIDsgZG8KCXQxPSQoJGNtZCB8IGdyZXAgVGltZSB8IGF3ayAne3ByaW50ICQy
fScpCgl0WyRpXT0kKGZ0b2kgJHQxIDMpCglwcmludGYgIiU2LjNmICIgJHQxCmRvbmUKCmF2
Zz0kKGF2ZXJhZ2UgJHt0WypdfSkKZmF2Zz0kKGl0b2YgYXZnIDMpCnN0ZD0kKHN0ZGV2ICR7
dFsqXX0pCnByaW50ZiAiICAgIEF2ZXJhZ2UgJS4zZiAgIHN0ZGV2ICUuMWYlJVxuIiAkZmF2
ZyAkc3RkCgo=
--------------C9659C45CF4A425E9F292B2F
Content-Type: text/plain; charset=UTF-8;
 name="hackdiff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="hackdiff"

IyEvYmluL3NoCiMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKIwojIEF1dGhv
cjogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4KIwojIFVzYWdl
OiBoYWNrZGlmZgojICAgUHJpbnQgZGlmZmVyZW5jZSBiZXR3ZWVuIDIgaWRlbnRpY2FsIHNl
cmllcyBvZiBoYWNrYmVuY2ggcnVucwojCiMgUmVhZHMgbGluZXMgZnJvbSBzdGRpbiBvZiB0
aGlzIGZvcm0gKGVnLCBmcm9tIHJ1bm1hbnkpOgojICBoYWNrYmVuY2ggMSBwcm9jZXNzIDEw
MDAwMAojICA1Ljc1MyAgNS40MjEgIDUuMjU0ICA2LjA0NCAgNS45ODkgICAgIEF2ZXJhZ2Ug
NS42OTIgICBzdGRldiA2LjElCiMKIyBUaGUgZmlyc3Qgb2NjdXJyZW5jZSBvZiBhIGhhY2ti
ZW5jaCBncm91cCBsaW5lIGlzIHRoZSBiYXNlIHNlcmllcywgYW5kIHRoZQojIG5leHQgb2Nj
dXJyZW5jZSB3aXRoIGlkZW50aWNhbCBwYXJhbWV0ZXJzIGlzIHRoZSBuZXcgc2VyaWVzLgoK
IyBDb252ZXJ0IGZsb2F0ICQxIHRvIGludGVncmFsIGZpeGVkLXBvaW50IHZhbHVlIHdpdGgg
JDIgZGVjaW1hbCBwbGFjZXMKIwpmdG9pKCkKewogICAgICAgIGRlY2xhcmUgLWkgdGVucz0x
MCoqJDIKICAgICAgICBlY2hvICQoZWNobyAic2NhbGU9MDsgKCR0ZW5zICogJDEpIC8gMSIg
fCBiYyAtcSkKfQoKIyBDb252ZXJ0IGludGVncmFsIGZpeGVkLXBvaW50ICQxIHdpdGggJDIg
ZGVjaW1hbCBwbGFjZXMgdG8gZmxvYXRpbmcgcG9pbnQKIyBzdHJpbmcKIwppdG9mKCkKewog
ICAgICAgIGRlY2xhcmUgLWkgaSBmcmFjIHRlbnMgeD0kMQogICAgICAgIHRlbnM9MTAqKiQy
CglbWyAkeCAtbHQgMCBdXSAmJiBzaWduPSctJyB4PSgtJHgpCiAgICAgICAgaT0keC90ZW5z
CiAgICAgICAgZnJhYz0keCV0ZW5zCiAgICAgICAgcHJpbnRmICIlcyVkLiUwJHsyfWQiICIk
c2lnbiIgJGkgJGZyYWMKfQoKZGVjbGFyZSAtYSB0MSB0MiB0MyBncm91cHMKZGVjbGFyZSAt
YSB3b3JkcwpkZWNsYXJlIC1hIHQxICB0MiAgZDEgIGQyIHdvcmRzIGdyb3VwcyBzZWVuX2dy
b3VwCmRlY2xhcmUgLWkgaSB0MWQgdDJkIHQzIG49MAoKYWZ0ZXI9ZmFsc2UKCndoaWxlIHJl
YWQgYnVmIDsgZG8KCWlmIFtbICR7YnVmOjA6OX0gPT0gImhhY2tiZW5jaCIgXV07IHRoZW4K
CQl3b3Jkcz0oJGJ1ZikKCQlncm91cD0ke3dvcmRzWzFdfQoJCWlmIFtbICR7c2Vlbl9ncm91
cFskZ3JvdXBdfSA9PSB0cnVlIF1dOyB0aGVuCgkJCWlmIFtbICRhZnRlciA9PSBmYWxzZSBd
XTsgdGhlbgoJCQkJbj0wCgkJCQlhZnRlcj10cnVlCgkJCWZpCgkJCWlmIFtbICR7Z3JvdXBz
WyRuXX0gIT0gJGdyb3VwIF1dOyB0aGVuCgkJCQllY2hvICJleHBlY3RlZCBncm91cCAke2dy
b3Vwc1skbl19ICIgXAoJCQkJICAgICAiYnV0IGZvdW5kICRncm91cCIKCQkJCWV4aXQgMQoJ
CQlmaQoJCWZpCgkJc2Vlbl9ncm91cFskZ3JvdXBdPXRydWUKCQlncm91cHNbJG5dPSRncm91
cAoKCWVsaWYgJChlY2hvICRidWYgfCBncmVwIC1xIEF2ZXJhZ2UpIDsgdGhlbgoJCXdvcmRz
PSgkKGVjaG8gJGJ1ZiB8IHNlZCAnIHMvXi4qQXZlcmFnZSAqLy8nKSkKCQlpZiBbWyAkYWZ0
ZXIgPT0gdHJ1ZSBdXTsgdGhlbgoJCQl0Mlskbl09JHt3b3Jkc1swXX0KCQkJZD0ke3dvcmRz
WzJdfQoJCQlkMlskbl09JHtkJVwlfQoJCWVsc2UKCQkJdDFbJG5dPSR7d29yZHNbMF19CgkJ
CWQ9JHt3b3Jkc1syXX0KCQkJZDFbJG5dPSR7ZCVcJX0KCQlmaQoJCW49KCRuKzEpCglmaQpk
b25lCgpwcmludGYgIiUyMXMgICUxM3NcbiIgIi0tLSBiYXNlIC0tIiAiLS0tIG5ldyAtLS0i
CnByaW50ZiAiJTZzICAlNnMgJTZzICAlNnMgJTZzICAlOHNcbiIgXAogICAgZ3JvdXBzICB0
aW1lIFwlc3RkZXYgIHRpbWUgXCVzdGRldiAgXCVzcGVlZHVwCgpmb3IgKChpPTA7IGk8JG47
IGkrKykpIDsgZG8KCXQxZD0kKGZ0b2kgJHt0MVskaV19IDMpCgl0MmQ9JChmdG9pICR7dDJb
JGldfSAzKQogICAgICAgIHQzPSgkdDFkKjEwMDAvJHQyZC0xMDAwKQogICAgICAgIHQzPSgk
dDMqMTAwKQogICAgICAgIHNwZWVkdXA9JChpdG9mICR0MyAzKQoJcHJpbnRmICIlNmQgICU2
LjNmICU2LjFmICAlNi4zZiAlNi4xZiAgJTguMWZcbiIgXAoJICAgICR7Z3JvdXBzWyRpXX0g
JHt0MVskaV19ICR7ZDFbJGldfSAke3QyWyRpXX0gJHtkMlskaV19ICRzcGVlZHVwCmRvbmUK
Cg==
--------------C9659C45CF4A425E9F292B2F--
