Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC363C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39CC20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfAUKpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:45:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbfAUKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:45:50 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LAhVOd053635
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:45:49 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q5chm86fj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:45:49 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Mon, 21 Jan 2019 10:45:48 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 10:45:44 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LAjhQQ12386534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 10:45:43 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAFD96A057;
        Mon, 21 Jan 2019 10:45:43 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27E3F6A05A;
        Mon, 21 Jan 2019 10:45:41 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.124.31.87])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jan 2019 10:45:40 +0000 (GMT)
Subject: Re: [PATCH v2] perf scripts python: Add Python 3 support to
 exported-sql-viewer.py
To:     Tony Jones <tonyj@suse.de>, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
 <1547718344-27382-3-git-send-email-s1seetee@linux.vnet.ibm.com>
 <f086e4fb-0bbf-9e21-25e2-708b092f1636@suse.de>
From:   seeteena <s1seetee@linux.vnet.ibm.com>
Date:   Mon, 21 Jan 2019 16:15:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f086e4fb-0bbf-9e21-25e2-708b092f1636@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19012110-0012-0000-0000-000016FDE72D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010445; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01149620; UDB=6.00599033; IPR=6.00929945;
 MB=3.00025220; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-21 10:45:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012110-0013-0000-0000-000055E74FFB
Message-Id: <4ce6c071-231e-7682-609e-dfc1d1d1e305@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/19/2019 06:15 AM, Tony Jones wrote:
> On 1/17/19 1:45 AM, Seeteena Thoufeek wrote:
>
>> +if sys.version_info[0] < 3:
>> +    import cPickle
>> +else:
>> +    import _pickle as cPickle
> Do you really need this?
>
> pickle is already in Python2.
>
> Also, did you test these changes on Python3?
>
> I think you'll find you also need the following hunk otherwise you're running into Unicode diffs on Py3.
>
> @@ -2590,8 +2590,8 @@ def Main():
>
>          is_sqlite3 = False
>          try:
> -               f = open(dbname)
> -               if f.read(15) == "SQLite format 3":
> +               f = open(dbname, "rb")
> +               if f.read(15) == b'SQLite format 3':
>                          is_sqlite3 = True
>                  f.close()
>          except:
>
> Plus you need to handle the conversion of "print >> sys.stderr"

Thanks Tony. added changes to handle the conversion of "print >> 
sys.stderr" in export-to-postgresql.py and export-to-sqlite.py file as 
well.  revised patch posted.
>
> Attached is my version (against tip):
>
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -91,7 +91,7 @@ import sys
>   import weakref
>   import threading
>   import string
> -import cPickle
> +import pickle
>   import re
>   import os
>   from PySide.QtCore import *
> @@ -1559,7 +1559,7 @@ class SQLTableDialogDataItem():
>   					return str(lower_id)
>
>   	def ConvertRelativeTime(self, val):
> -		print "val ", val
> +		print("val ", val)
>   		mult = 1
>   		suffix = val[-2:]
>   		if suffix == "ms":
> @@ -1581,29 +1581,29 @@ class SQLTableDialogDataItem():
>   		return str(val)
>
>   	def ConvertTimeRange(self, vrange):
> -		print "vrange ", vrange
> +		print("vrange ", vrange)
>   		if vrange[0] == "":
>   			vrange[0] = str(self.first_time)
>   		if vrange[1] == "":
>   			vrange[1] = str(self.last_time)
>   		vrange[0] = self.ConvertRelativeTime(vrange[0])
>   		vrange[1] = self.ConvertRelativeTime(vrange[1])
> -		print "vrange2 ", vrange
> +		print("vrange2 ", vrange)
>   		if not self.IsNumber(vrange[0]) or not self.IsNumber(vrange[1]):
>   			return False
> -		print "ok1"
> +		print("ok1")
>   		beg_range = max(int(vrange[0]), self.first_time)
>   		end_range = min(int(vrange[1]), self.last_time)
>   		if beg_range > self.last_time or end_range < self.first_time:
>   			return False
> -		print "ok2"
> +		print("ok2")
>   		vrange[0] = self.BinarySearchTime(0, self.last_id, beg_range, True)
>   		vrange[1] = self.BinarySearchTime(1, self.last_id + 1, end_range, False)
> -		print "vrange3 ", vrange
> +		print("vrange3 ", vrange)
>   		return True
>
>   	def AddTimeRange(self, value, ranges):
> -		print "value ", value
> +		print("value ", value)
>   		n = value.count("-")
>   		if n == 1:
>   			pass
> @@ -2577,7 +2577,7 @@ class DBRef():
>
>   def Main():
>   	if (len(sys.argv) < 2):
> -		print >> sys.stderr, "Usage is: exported-sql-viewer.py {<database name> | --help-only}"
> +		sys.stderr.write("Usage is: exported-sql-viewer.py {<database name> | --help-only}\n");
>   		raise Exception("Too few arguments")
>
>   	dbname = sys.argv[1]
> @@ -2590,8 +2590,8 @@ def Main():
>
>   	is_sqlite3 = False
>   	try:
> -		f = open(dbname)
> -		if f.read(15) == "SQLite format 3":
> +		f = open(dbname, "rb")
> +		if f.read(15) == b'SQLite format 3':
>   			is_sqlite3 = True
>   		f.close()
>   	except:
>
>
>
>
>



