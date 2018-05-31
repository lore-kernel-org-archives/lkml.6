Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbeEaJ2y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:28:54 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:23629 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754164AbeEaJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:28:51 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180531092849epoutp010e13475450b548b0a9d822622d52a684~zsKcCDzGW0715207152epoutp01c
X-AuditID: b6c32a35-ba1ff70000000fe2-0f-5b0fc051b775
From: CHANDAN VN <chandan.vn@samsung.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, bfields@fieldses.org,
        jlayton@kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, casey@schaufler-ca.com
Cc: cpgs@samsung.com, chandan.vn@samsung.com, sireesha.t@samsung.com
Subject: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set and
 kernfs_security_xattr_set
Date: Thu, 31 May 2018 14:58:31 +0530
Message-id: <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7bCmgW7gAf5og31nZCxeTImyuLftF5vF
        hC8RFi8PaVo0L17PZvFz2Sp2i8u75rBZXDhwmtVi14UCi1/LjzI6cHlsmNrE5rFpVSebx/65
        a9g9+rasYvQ4un8Rm8fnTXIBbFGpNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZK
        CnmJuam2Si4+AbpumTlAZykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWiDQ2N9AwNzPWM
        jIC0aayVkSlQSUJqxpYTGxkLJohVPHi3kLWB8Z5QFyMnh4SAicTyl3PZuhi5OIQEdjBKNMye
        wwjhfGeU+HloDxNM1erZj1ghErsZJSZtvc4E4XQzSZzpeMUCUsUmoClxYt40dpCEiMAaRolz
        a3YwgySYBVwkTv7vYQSxhQUSJe7teA1mswioSsx99h1sBa+Am8TZD5fZINbJSZw8NhlsnYRA
        D5vEnW8guzmAHBeJ1uXREDXCEq+Ob2GHCEtLXDpqC2HmS7zarQBRUSHxv2ErC4RtLzFj8Vao
        a/gk3n3tgRrIK9HRBg0JD4lXrYvASoQEYiVmrH3BNoFRYgEjwypGsdSC4tz01GLDAkO94sTc
        4tK8dL3k/NxNjOC0oWW6g3HKOZ9DjAIcjEo8vBxr+KKFWBPLiitzDzFKcDArifBOKeOPFuJN
        SaysSi3Kjy8qzUktPsRoCvT/RGYp0eR8YErLK4k3NDUyMzOwNLc0szCwUBLnbTP/FyUkkJ5Y
        kpqdmlqQWgTTx8TBKdXAeDG/IpFF2DNAZnOyhafctTMGX7KcllvdMbGqeyOpx7Pz1b/1G2aV
        /2csOrr7zYXAYPaAWeXLnly5K7FA8e6VHYv/BhesNzezdW0odPjkaTSdu+qzVSuH0/InnrUL
        emxju71C4pcvWV3gl3x61oUpify/WaYfdg/aP6f8bbRlcfyzZSKbvik8VGIpzkg01GIuKk4E
        ADzl8tAxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplluLIzCtJLcpLzFFi42I5/e+xgG7AAf5og/PvlS1eTImyuLftF5vF
        hC8RFi8PaVo0L17PZvFz2Sp2i8u75rBZXDhwmtVi14UCi1/LjzI6cHlsmNrE5rFpVSebx/65
        a9g9+rasYvQ4un8Rm8fnTXIBbFFcNimpOZllqUX6dglcGVtObGQsmCBW8eDdQtYGxntCXYyc
        HBICJhKrZz9i7WLk4hAS2Mko0bxhCQuE08sksWnBGXaQKjYBTYkT86axgyREBNYwSkx/uI4R
        JMEs4CJx8n8PmC0skChxb8drMJtFQFVi7rPvTCA2r4CbxNkPl9kg1slJnDw2mXUCI9cCRoZV
        jJKpBcW56bnFRgWGeanlesWJucWleel6yfm5mxiBgbPtsFbfDsb7S+IPMQpwMCrx8HKs4YsW
        Yk0sK67MPcQowcGsJMI7pYw/Wog3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6Yklqdmp
        qQWpRTBZJg5OqQbGkvwJHIZ/o6e8mhw6XdzGgDM+XXpZOofkB0PRBzqPu16c5RK+K6ksd+H1
        AVmOZVznXlzy2xiRcrCOaUqS9PIejjWuXVeCUgOfeS8UMC2cpBup/ZD3BMfcf9pnMzzD1Zdw
        uy77tFkxlTWBaaetws7W1yEdz1KXHyo2dljbNXV+4Pkvjcu2LxJVYinOSDTUYi4qTgQA5E47
        lRgCAAA=
X-CMS-MailID: 20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b
References: <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "sireesha.t" <sireesha.t@samsung.com>

Leak is caused because smack_inode_getsecurity() is allocating memory
using kstrdup(). Though the security_release_secctx() is called, it
would not free the allocated memory. Calling security_release_secctx is
not relevant for this scenario as inode_getsecurity() does not provide a
"secctx".

Similar fix has been mainlined:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=57e7ba04d422c3d41c8426380303ec9b7533ded9

The fix is to replace the security_release_secctx() with a kfree()

Below is the KMEMLEAK dump:
unreferenced object 0xffffffc025e11c80 (size 64):
  comm "systemd-tmpfile", pid 2452, jiffies 4294894464 (age 235587.492s)
  hex dump (first 32 bytes):
    53 79 73 74 65 6d 3a 3a 53 68 61 72 65 64 00 00  System::Shared..
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffff80081be770>] __save_stack_trace+0x28/0x34
    [<ffffff80081bedb8>] create_object+0x130/0x25c
    [<ffffff80088c82f8>] kmemleak_alloc+0x30/0x5c
    [<ffffff80081b3ef0>] __kmalloc_track_caller+0x1cc/0x2a8
    [<ffffff800818673c>] kstrdup+0x3c/0x6c
    [<ffffff80082d78b0>] smack_inode_getsecurity+0xcc/0xec
    [<ffffff80082d78f4>] smack_inode_getsecctx+0x24/0x44
    [<ffffff80082d5ea0>] security_inode_getsecctx+0x50/0x70
    [<ffffff800823bbcc>] kernfs_security_xattr_set+0x74/0xe0
    [<ffffff80081eafec>] __vfs_setxattr+0x74/0x90
    [<ffffff80081eb088>] __vfs_setxattr_noperm+0x80/0x1ac
    [<ffffff80081eb238>] vfs_setxattr+0x84/0xac
    [<ffffff80081eb374>] setxattr+0x114/0x178
    [<ffffff80081eb44c>] path_setxattr+0x74/0xb8
    [<ffffff80081ebdcc>] SyS_lsetxattr+0x10/0x1c
    [<ffffff800808310c>] __sys_trace_return+0x0/0x4

Signed-off-by: sireesha.t <sireesha.t@samsung.com>
Signed-off-by: CHANDAN VN <chandan.vn@samsung.com>
---
 fs/kernfs/inode.c | 3 ++-
 fs/nfsd/nfs4xdr.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index a343039..53befb8 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -369,7 +369,8 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 	mutex_unlock(&kernfs_mutex);
 
 	if (secdata)
-		security_release_secctx(secdata, secdata_len);
+		kfree(secdata);
+
 	return error;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index aaa88c1..1e0dbe9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2911,7 +2911,7 @@ static int get_parent_attributes(struct svc_export *exp, struct kstat *stat)
 out:
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (context)
-		security_release_secctx(context, contextlen);
+		kfree(context);
 #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	kfree(acl);
 	if (tempfh) {
-- 
1.9.1
