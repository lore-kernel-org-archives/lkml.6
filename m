Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1148932-1519337447-2-14081301931992417478
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519337446; b=lSmqBXuaxu6Q73FlGTNS4YuXl/rei3aS4sdGNBNq3I+67j9
    kjovZ6rSKBccVpnkYECSf98lmBTAv5pmdV0grWzlGb0BgGxdqihzRqoAsalHArZP
    WbYAV7aznkTJWzLU4tCjHCUymYyj1JDv8JPvkTiXYQEtOih2wbSDOY8wOcIbwnfY
    uIF0jxVs3hbeLRi//3qrhPt+TYOJvHRFwWhmMM2W1Vmq0b7TqrMUlYt0Hs+ln8SK
    o05yIhYUGGPBNDRZLHUZJz8OuZh0koMH7vziX7CPSYTo1wjU3rP/gNof0zXkp2tP
    K3JBbPe5/3kbssn8PucG5QMkznmdJ/Lndg9s9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519337446; bh=E
    CPcqzmNyX+QOjR5yqBSANFSrcZ+RN512kiWAZ+yZqg=; b=mdguevYymdm+nb5Gd
    c9aDZfeymHXnDDMK4jj+wAXkIGzXM5CAEzWUUETRZwi48NbOfZLiLz/cngdNtGFd
    QZ4DQZN5GAkLsK+8OfmR8QZUJFm9GK+a52W5H5w0D0LR3zgyb/pluATRNwe5gyT3
    dPSh+OSUormuLSIXXw+giXxyi61a9jP1U05HznpjrebvXNJJGZs7RathBdStP6eK
    1yKwR+nmn/66+TwyyFKgdwkvwQJQCH6djwzRnOUMhN1j+GU3b4nOHJiv2COrF+9E
    fLZUa09UiwwxLuT6R3YS2diRZhDoGBlG1uhQkn1PoZEUntTLS2h9awUY4S66+lkH
    d3y0A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 23 Feb 2018 09:09:33 +1100
Subject: [PATCH 1/3] staging: lustre: lov: use correct env in
 lov_io_data_version_end()
Message-ID: <151933737380.16436.3113702074708223689.stgit@noble>
In-Reply-To: <151933726925.16436.9827896439357574011.stgit@noble>
References: <151933726925.16436.9827896439357574011.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

lov - the logical object volume manager - is responsible for
striping data across multiple volumes.

So when it is given a request, it creates one or more
sub-requests, one for each target volume.  Each sub_io
request has a sub_env environment which it operates in.

When lov_io_data_version_end() calls lov_io_end_wrapper() to
wait for and close off a sub_io, it passes the wrong
environment.

This causes an LINVRNT() to fail in cl2osc_io(), and may
cause other problems.

This patch changes the call to use ->sub_env, much like
other code in the same file.

Fixes: f0cf21abcccc ("staging: lustre: clio: add CIT_DATA_VERSION and remove IOC_LOV_GETINFO")
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/lov/lov_io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/lov/lov_io.c b/drivers/staging/lustre/lustre/lov/lov_io.c
index c0dbf6cd53b4..b823f8a21856 100644
--- a/drivers/staging/lustre/lustre/lov/lov_io.c
+++ b/drivers/staging/lustre/lustre/lov/lov_io.c
@@ -483,7 +483,7 @@ lov_io_data_version_end(const struct lu_env *env, const struct cl_io_slice *ios)
 	struct lov_io_sub *sub;
 
 	list_for_each_entry(sub, &lio->lis_active, sub_linkage) {
-		lov_io_end_wrapper(env, sub->sub_io);
+		lov_io_end_wrapper(sub->sub_env, sub->sub_io);
 
 		parent->u.ci_data_version.dv_data_version +=
 			sub->sub_io->u.ci_data_version.dv_data_version;


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
