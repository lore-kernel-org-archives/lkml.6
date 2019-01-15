Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6160CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B5620645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfAOPLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:11:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730639AbfAOPLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:11:48 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0FF4AC3008090
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:11:47 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q1ewfhh2c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:11:46 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 15 Jan 2019 15:11:45 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 15 Jan 2019 15:11:41 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0FFBd9e25886816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 15:11:39 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4B7A78066;
        Tue, 15 Jan 2019 15:11:39 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BE687805F;
        Tue, 15 Jan 2019 15:11:39 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 15 Jan 2019 15:11:39 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 15 Jan 2019 10:17:13 -0500
From:   nayna <nayna@linux.vnet.ibm.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Kairui Song <kasong@redhat.com>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, jwboyer@fedoraproject.org,
        keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
In-Reply-To: <20190115024243.GA9199@dhcp-128-65.nay.redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
 <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
 <1547223220.19931.471.camel@linux.ibm.com>
 <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
 <1547482251.4156.127.camel@linux.ibm.com>
 <20190115024243.GA9199@dhcp-128-65.nay.redhat.com>
X-Sender: nayna@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
x-cbid: 19011515-0012-0000-0000-000016FA6096
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010411; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01146863; UDB=6.00597358; IPR=6.00927155;
 MB=3.00025137; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-15 15:11:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011515-0013-0000-0000-000055D416D9
Message-Id: <3c80c88c90ead96cea9a4f13af41fc5b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901150126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-14 21:42, Dave Young wrote:
> On 01/14/19 at 11:10am, Mimi Zohar wrote:
>> On Sun, 2019-01-13 at 09:39 +0800, Dave Young wrote:
>> > Hi,
>> >
>> > On 01/11/19 at 11:13am, Mimi Zohar wrote:
>> > > On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
>> > > [snip]
>> > >
>> > > > Personally I would like to see platform key separated from integrity.
>> > > > But for the kexec_file part I think it is good at least it works with
>> > > > this fix.
>> > > >
>> > > > Acked-by: Dave Young <dyoung@redhat.com>
>> > >
>> > > The original "platform" keyring patches that Nayna posted multiple
>> > > times were in the certs directory, but nobody commented/responded.  So
>> > > she reworked the patches, moving them to the integrity directory and
>> > > posted them (cc'ing the kexec mailing list).  It's a bit late to be
>> > > asking to move it, isn't it?
>> >
>> > Hmm, apologize for being late,  I did not get chance to have a look the
>> > old series.  Since we have the needs now, it should be still fine
>> >
>> > Maybe Kairui can check Nayna's old series, see if he can do something
>> > again?
>> 
>> Whether the platform keyring is defined in certs/ or in integrity/ the
>> keyring id needs to be accessible to the other, without making the
>> keyring id global.  Moving where the platform keyring is defined is
>> not the problem.
> 
> Agreed, but just feel kexec depends on IMA sounds not good.

The platform keyring is not dependent on IMA, it is dependent on 
"integrity" - CONFIG_INTEGRITY_ASYMMETRIC_KEYS.
Other CONFIGS which it needs are CONFIG_SYSTEM_BLACKLIST_KEYRING, 
CONFIG_EFI.

Thanks & Regards,
    - Nayna

