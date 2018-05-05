Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1542750-1525508975-2-236237297640929366
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525508974; b=B3Sq6le/nxIK+8yDt9Ke5MemkSD4yxZ0jV6eaV7pKI+/MtrikV
    sLx9MY2b7iQ8HX6wmCjbTvY9mtRB7dgJD5c9QSNoW3PMhZZEiwyZKJy4v7XNbJai
    SWMDBrnWGCADZ3zHhdIM/kRe0GHG2rZlV166KzynSCvwyDT+Jizou8K83k7/xCFZ
    /s+6oXrPSkJUSnXrx2Zm3UC3aiu/k3Gr8b2vU2E0PbFVoSrdybEAFL3CbV/EckLo
    1SJCnMfSz8U6SbRc2/PvKu/cijRsRD+q2Tv4dVEzpK3JoJ3TYb9uOY1uZwcswyBJ
    92sU0Oa8ji1fUy+B6JGvDjXRmzYhdWDujeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525508974; bh=KGTLM
    5FomsNRtGdlsiBDRE0GJh2I+XYkACtm0Pe9YaE=; b=XvpFjGmaPp+/YS5+ogAwm
    ULp1Va3/nF3xltuibEgdPjm96awrQ4Ej6lqk55aZFvkqT2WxPn7wpneaWyI3xtcm
    7bsmBwORTM/nhXY04RdZ3s+NoDSGWl00XTbU1Z1M0tZshwzgJn/lHeHbabVOG1u1
    YGsu5g8CWciDpM46naxFBjbYuByr6dJUPaFMOcqi7y1oNTV0Sg6tzZv4Ktn/O265
    dpBIqjVAFazG32z/O5+UzvnCq0//u96oNt3jgTOe4yvVBvBgIEhawBqxZpdgYCM8
    EoAiGL6idccYmAH1J9MtulWEzijoCbJc/coJbg1HUpw3iKQgQmitG38f/WQyia38
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=lf09Gvci x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=lf09Gvci x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD7/vCbSlK9EaHMqAeSb3AJhfs0/un0YDRimB3FBIgcy8oef2AeGxffUmypECy0SkKiAMQmgts9KXDQOtIfrArIZdJv9gwN+KXh9lSSI+KLqABfIuL65
    hc1hM9gscTvVBnTXYS2CAacu/6uyq6vJeuasbugyPHJR9Qshce5vZt9qVdimXEZVrgByUj44h7Df4NNO9TqrTH4NObf5/3+Xu2aMyO/D9TNdJBelzxCTIxAF
    0ACyTzziRZBZXL7alTEvZg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=sOK_bZnoAqTFMIwO9lsA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 5 May 2018 11:29:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH v2] staging: lustre: llite: fix potential missing-check
 bug when copying lumv
Message-ID: <20180505082912.r4a6tawjv7ykedc7@mwanda>
References: <CAK8Kejq0h_Rgq__W_KSD_u+KUbS=cYkVXoHJpdbDrmYOU+iJDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8Kejq0h_Rgq__W_KSD_u+KUbS=cYkVXoHJpdbDrmYOU+iJDg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8883
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=672
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805050079
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
 Roman Storozhenko <romeusmeister@gmail.com>, "Dilger,
 Andreas" <andreas.dilger@intel.com>, Jeff Layton <jlayton@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wenwen Wang <wang6495@umn.edu>, NeilBrown <neilb@suse.com>,
 open list <linux-kernel@vger.kernel.org>, "Drokin,
 Oleg" <oleg.drokin@intel.com>,
 "moderated list:STAGING - LUSTRE PARALLEL FILESYSTEM"
 <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 10:01:44AM -0500, Kangjie Lu wrote:
> > There is nothing preventing the user from using struct lov_mds_md_v3 but
> > filling in lmm_magic = LOV_MAGIC_V1 from the beginning, no need for a race.
> >
> 
> Right. No need for users to race. There might be a type confusion issue
> though if V1
> object is  used as V3 or the other way.
> 

It's a bit confusing for someone reading the code, but in terms of the
kernel it's straightforward.

It's like if someone is typing with their toes, that's sort of confusing
but it's not a security issue.  And here we're implementing a no typing
with your toes policy just to make things more higienic (static checkers
in this metaphor).

regards,
dan carpenter
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
