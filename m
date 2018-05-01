Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2842537-1525164402-2-3948953129483082139
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525164401; b=ikLcsIfpXLe+mnUDCrBFYkimSFKeYnfVvRs/EgMYWsHcw1Xl6p
    5EocMljbGM2HJCMMUXxSEtOrcNBsBgyty3c96Sq4Sfp6Wg+vy4li7xYrP6Fpv6MY
    VzyCbb+CIg20O3yc3ksRkTi9jcCwHg/X33ytEtU8qiMxrVDaQcf+UsHF+mORevpP
    5cKo24iAiDaiyDWCuUcY5+FfnxSAm/6TGJNVpvAQIUXo0Bb6qhPC1xorUupkGGMj
    YTE8TrAzjVRcDJGhE8MgYf5NQaG4nxxLsFdi5qLOjnpYjSAa9JdF3whRMaz1nZTn
    02fWmErSVqPesN1mfiaBwIfSkfTHgxm/Lpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525164401; bh=HmPSC
    Hd9oA5mgIzL/Oy3oeu3uPU2QoR5jM5dufL6QPQ=; b=GPiTPQ7K6eDUVKrMAP+jr
    goYz6Wz7OmK71qt8b5tEIKSXswZdTLjYzcd4dA7nwKQd37D02lku5w/CV13ei4gj
    ZvjDuWgmfbBTt0a1Hku/hTB+XkEu88tIftCS69L3/ZsViNvMiZticAJand/dB1yG
    n9m0yxyLHNGd/pIJ5EOb8rSD8XcSDbN5vxz+fsyk2wZZwEYMfBOFRTOOkFo6q7IS
    dYVBpjT8JVcs2e6zTNJj46sPDOy5sj3daaU+1J/4ySLCbkLu4o2R47LteHvnxp80
    hotH5pApf374NJagEu5ke91Z730e+E1X7kGFKacmKFauGoYFB0aDK7eb2Hxs8O8i
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=d8+izKw+ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=d8+izKw+ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNJSdpQshAu5XkeuPYcam8nf3KSutWyLwfCLgB5BnvYge6PK400qRxhjC7EbdqsVUNjTOoBpxEDPbXVQarsrny85dayY6vByWVOcncfPkHVYCXH7Rjpx
    yZfCKSF0N2Yj9csN9VxLohiiYpnwNwWcXY8bbaQzvVhkJEtEHgojQxxVCkjpRzGmu0rz5h/oiW56jWNuicqTpeASeHVOy5tJiIV6heWfVfRwrvVBwboTikFd
    KD25beCy4HE8syLYYdR6lw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=-BjXJ9sfrBn2sq2D9cAA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 1 May 2018 11:46:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wenwen Wang <wang6495@umn.edu>
Subject: Re: [PATCH v2] staging: lustre: llite: fix potential missing-check
 bug when copying lumv
Message-ID: <20180501084621.jfxrm3qoqfmftnxh@mwanda>
References: <1525128971-8946-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1525128971-8946-1-git-send-email-wang6495@umn.edu>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=758
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805010090
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Aastha Gupta <aastha.gupta4104@gmail.com>,
 Roman Storozhenko <romeusmeister@gmail.com>,
 Andreas Dilger <andreas.dilger@intel.com>, Jeff Layton <jlayton@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kangjie Lu <kjlu@umn.edu>,
 NeilBrown <neilb@suse.com>, open list <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 "moderated list:STAGING - LUSTRE PARALLEL FILESYSTEM"
 <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 05:56:10PM -0500, Wenwen Wang wrote:
> However, given that the user data resides in the user space, a malicious
> user-space process can race to change the data between the two copies. By
> doing so, the attacker can provide a data with an inconsistent version,
> e.g., v1 version + v3 data. This can lead to logical errors in the
> following execution in ll_dir_setstripe(), which performs different actions
> according to the version specified by the field lmm_magic.

This part is misleading.  The fix is to improve readability and make
static checkers happy.  You're over dramatizing it to make people think
it has a security impact when it doesn't.

If the user wants to specify v1 data they can just say that on the first
read.  They don't need to do funny tricks and race between the two
reads.  It's allowed.

In other words this allows the user to do something in a very
complicated way which they are already allowed to do in a very simple
straight forward way.

regards,
dan carpenter
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
