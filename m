Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591608-2-10508673186300276765
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591607; b=hZqpst9HERHQdKG9r2u+Xga9GHq6o5rNL2bVyeE/mu8ma2b
    NwNgPw8lDskWMA/WBGkU8caplNb4MLDktZzA4lFwacTKmu6AzrX5EU6H8x37Mw6H
    Md6T0516V/rMCbCvSBpm/6nBZUSYikMtiEoJKShwMFO0HB5ict4I3DuBmOeyPlmY
    qwOocmLCqS67gBxobMDxTwZB3odijBpT1bbTpZf9bNnLePO1UNohmTrQttk7o/29
    Ywt0PJyjkG2rWs2/hZc6QVC6nVcqFXVsKGCBT23dwxyNRlghALUmensu+ONqUnv8
    pmtAqv2Nvjux9JGQD4zT2Dzt5p/Hedgc+v95Qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591607; bh=vwPauLzrJzyMYYsaAgjfygYF+F
    2lUSOYXJQfAi0+SBw=; b=fJe3NHX0bq16hHNxkaWArTjXqwsyx3xcY5ekocQyOF
    BgajdagGUR50XJwusHKz/AjTc5fyiKB1jp6Qu+DfdkRdKcdRRti4r4Zn6dQgU6Vo
    mm59N5JU9V+nYUv9GcJsFVsZqxxTOCS7Y/xQf9JpD5SoPg2MKkTqppNCHxdyw+Ox
    4qBK3OJEGGfIUM2b6wPNnp1gV36oihJGL0Oj/VgSKM+TNRh89jEFS+RHl3VVb5v9
    7YuBKcaGYxXOX62UE1Dx3Ya7a2Q85BMOGz3yw0r8a8cRzSWoMONTGTLShnWlYF+M
    wm5pOA9DVN6UEUXYhEJrLdi5gN/G5lUpDAlvuNbOAVLQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbeBBRNX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:13:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbeBBRNL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:13:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Changcheng <changcheng.liu@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        NeilBrown <neilb@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 103/156] scripts/faddr2line: extend usage on generic arch
Date: Fri,  2 Feb 2018 17:58:04 +0100
Message-Id: <20180202140844.857269882@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Liu, Changcheng" <changcheng.liu@intel.com>


[ Upstream commit 95a87982541932503d3f59aba4c30b0bde0a6294 ]

When cross-compiling, fadd2line should use the binary tool used for the
target system, rather than that of the host.

Link: http://lkml.kernel.org/r/20171121092911.GA150711@sofia
Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: NeilBrown <neilb@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/faddr2line |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -44,9 +44,16 @@
 set -o errexit
 set -o nounset
 
+READELF="${CROSS_COMPILE}readelf"
+ADDR2LINE="${CROSS_COMPILE}addr2line"
+SIZE="${CROSS_COMPILE}size"
+NM="${CROSS_COMPILE}nm"
+
 command -v awk >/dev/null 2>&1 || die "awk isn't installed"
-command -v readelf >/dev/null 2>&1 || die "readelf isn't installed"
-command -v addr2line >/dev/null 2>&1 || die "addr2line isn't installed"
+command -v ${READELF} >/dev/null 2>&1 || die "readelf isn't installed"
+command -v ${ADDR2LINE} >/dev/null 2>&1 || die "addr2line isn't installed"
+command -v ${SIZE} >/dev/null 2>&1 || die "size isn't installed"
+command -v ${NM} >/dev/null 2>&1 || die "nm isn't installed"
 
 usage() {
 	echo "usage: faddr2line <object file> <func+offset> <func+offset>..." >&2
@@ -69,10 +76,10 @@ die() {
 find_dir_prefix() {
 	local objfile=$1
 
-	local start_kernel_addr=$(readelf -sW $objfile | awk '$8 == "start_kernel" {printf "0x%s", $2}')
+	local start_kernel_addr=$(${READELF} -sW $objfile | awk '$8 == "start_kernel" {printf "0x%s", $2}')
 	[[ -z $start_kernel_addr ]] && return
 
-	local file_line=$(addr2line -e $objfile $start_kernel_addr)
+	local file_line=$(${ADDR2LINE} -e $objfile $start_kernel_addr)
 	[[ -z $file_line ]] && return
 
 	local prefix=${file_line%init/main.c:*}
@@ -104,7 +111,7 @@ __faddr2line() {
 
 	# Go through each of the object's symbols which match the func name.
 	# In rare cases there might be duplicates.
-	file_end=$(size -Ax $objfile | awk '$1 == ".text" {print $2}')
+	file_end=$(${SIZE} -Ax $objfile | awk '$1 == ".text" {print $2}')
 	while read symbol; do
 		local fields=($symbol)
 		local sym_base=0x${fields[0]}
@@ -156,10 +163,10 @@ __faddr2line() {
 
 		# pass real address to addr2line
 		echo "$func+$offset/$sym_size:"
-		addr2line -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;"
+		${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;"
 		DONE=1
 
-	done < <(nm -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
+	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
 }
 
 [[ $# -lt 2 ]] && usage
