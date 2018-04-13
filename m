Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeDMQZP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:25:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750837AbeDMQZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:25:13 -0400
Subject: Re: [RFC PATCH v3 1/3] ima: extend clone() with IMA namespace
 support
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        tycho@docker.com, serge@hallyn.com, sunyuqiong1988@gmail.com,
        david.safford@ge.com, mkayaalp@cs.binghamton.edu,
        James.Bottomley@HansenPartnership.com, Yuqiong Sun <suny@us.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        John Johansen <john.johansen@canonical.com>
Date: Fri, 13 Apr 2018 12:25:02 -0400
In-Reply-To: <87sh8lcecn.fsf@xmission.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
         <1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
         <87sh8lcecn.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041316-0008-0000-0000-000004EA490B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041316-0009-0000-0000-00001E7E57BF
Message-Id: <1523636702.3272.63.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130150
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc'ing John Johansen]

On Tue, 2018-03-27 at 18:01 -0500, Eric W. Biederman wrote:
[...]
> As such I expect the best way to create the ima namespace is by simply
> writing to securityfs/imafs.  Possibly before the user namespace is
> even unshared.  That would allow IMA to keep track of things from
> before a container is created.

My initial thought was to stage IMA namespacing with just IMA-audit
first, followed by either IMA-measurement or IMA-appraisal.  This
would allow us to get the basic IMA namespacing framework working and
defer dealing with the securityfs related namespacing of the IMA
policy and measurement list issues to later.

By tying IMA namespacing to a securityfs ima/unshare file, we would
need to address the securityfs issues first.

Mimi
