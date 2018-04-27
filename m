Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839544-2-17356769080202923050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839543; b=BB5vAHyWBPTAP5Jd7jNOz1KP8J8uBqegbe92z/yMydUWXYwN9Y
    UoZhweHFfu/cc4AkPnKek7hHK4+Sa3so0AYu1mrWYC72UwfRjF9SWh4u6RRrnbsB
    lb7eg1rH4OGAhVTLIOAvHVu4QfKQcd4/KMZPAD8O6W4VPlNlTBXl/66iCdiG0mX2
    J+cB/mXvU8FRrFx4A80E4emGAHAOIf90FiZGtMVuaUaXmPprm6ml0vTUHqCe+UYb
    FByFZ+2N62LBamTcOGcquiE0lnGa3CahvX3LDMLOfTALDUsVtP4CMnxwkb7tO9X0
    j8mxqZ+ghsATH/jahf6b+xHbV7em6zJyVs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839543; bh=FvcuiHy2U4yW18F1QHvGzK1KlCvC7y
    5NEuxOnuaAuM8=; b=gyBfRorMsDy9/eGKFzPJxUEagO9oCNIhyK9/LlFlyk4Ccv
    0CLKColUzWwVHIf4uapqgGYQsGyiMdFPqi3+dMjahvn0XU9Fmy+Rgs1tmXOwnokK
    rvEGH72OgrKIwsHDo3T9KpBBMYwE1ZD4YE5Y9uU8qNipPhbXXK3WCg8jYyrTqLpH
    rkMKNnGDcrH9jNjEHX9C7oLdHj9hCHXDi7tTRvs6su3RnEbx+EKpQ/tJX0XOKSA1
    x43CQCiqE+7BILuArtOWEz4xjO7rkeLbVjm0vQwOskHt5ET20tE9QQVO/teQ3CVY
    WvDy8ie7Frnql/ojL+dCHT0ij+G/Br4R5sXUMVpQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDrAQUImEHrxQxIjx9+anheKehctyJB7fNcSXJHk5Mu93eFpFliS525MU2bc6MXvD47mtqmlFRNmGAIhfP3F0jbuJRRZ0tkc+9ZTpKqPzffCleh1MdON
    SX+z6V9zaZbuz2Bp+STFnR1SPp0yHyJ4wFrnYvMJK/kVmjpladc76RJaAAjLgpRpe2X+ssJVTpQBEphB3zXkOAO2r8YlretEPI3OHhPfUHxq/d6g8nR8O72f
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=jqAmP0lIdi3pUuq-h1kA:9
    a=Y7EzFmk7DsenKuM0:21 a=5I7q0ltCTpXhu5VR:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934898AbeD0OcG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934356AbeD0OKa (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD80421864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 28/81] tcp: dont read out-of-bounds opsize
Date: Fri, 27 Apr 2018 15:58:30 +0200
Message-Id: <20180427135744.750255987@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>


[ Upstream commit 7e5a206ab686f098367b61aca989f5cdfa8114a3 ]

The old code reads the "opsize" variable from out-of-bounds memory (first
byte behind the segment) if a broken TCP segment ends directly after an
opcode that is neither EOL nor NOP.

The result of the read isn't used for anything, so the worst thing that
could theoretically happen is a pagefault; and since the physmap is usually
mostly contiguous, even that seems pretty unlikely.

The following C reproducer triggers the uninitialized read - however, you
can't actually see anything happen unless you put something like a
pr_warn() in tcp_parse_md5sig_option() to print the opsize.

====================================
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <stdlib.h>
#include <errno.h>
#include <stdarg.h>
#include <net/if.h>
#include <linux/if.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/in.h>
#include <linux/if_tun.h>
#include <err.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <assert.h>

void systemf(const char *command, ...) {
  char *full_command;
  va_list ap;
  va_start(ap, command);
  if (vasprintf(&full_command, command, ap) == -1)
    err(1, "vasprintf");
  va_end(ap);
  printf("systemf: <<<%s>>>\n", full_command);
  system(full_command);
}

char *devname;

int tun_alloc(char *name) {
  int fd = open("/dev/net/tun", O_RDWR);
  if (fd == -1)
    err(1, "open tun dev");
  static struct ifreq req = { .ifr_flags = IFF_TUN|IFF_NO_PI };
  strcpy(req.ifr_name, name);
  if (ioctl(fd, TUNSETIFF, &req))
    err(1, "TUNSETIFF");
  devname = req.ifr_name;
  printf("device name: %s\n", devname);
  return fd;
}

#define IPADDR(a,b,c,d) (((a)<<0)+((b)<<8)+((c)<<16)+((d)<<24))

void sum_accumulate(unsigned int *sum, void *data, int len) {
  assert((len&2)==0);
  for (int i=0; i<len/2; i++) {
    *sum += ntohs(((unsigned short *)data)[i]);
  }
}

unsigned short sum_final(unsigned int sum) {
  sum = (sum >> 16) + (sum & 0xffff);
  sum = (sum >> 16) + (sum & 0xffff);
  return htons(~sum);
}

void fix_ip_sum(struct iphdr *ip) {
  unsigned int sum = 0;
  sum_accumulate(&sum, ip, sizeof(*ip));
  ip->check = sum_final(sum);
}

void fix_tcp_sum(struct iphdr *ip, struct tcphdr *tcp) {
  unsigned int sum = 0;
  struct {
    unsigned int saddr;
    unsigned int daddr;
    unsigned char pad;
    unsigned char proto_num;
    unsigned short tcp_len;
  } fakehdr = {
    .saddr = ip->saddr,
    .daddr = ip->daddr,
    .proto_num = ip->protocol,
    .tcp_len = htons(ntohs(ip->tot_len) - ip->ihl*4)
  };
  sum_accumulate(&sum, &fakehdr, sizeof(fakehdr));
  sum_accumulate(&sum, tcp, tcp->doff*4);
  tcp->check = sum_final(sum);
}

int main(void) {
  int tun_fd = tun_alloc("inject_dev%d");
  systemf("ip link set %s up", devname);
  systemf("ip addr add 192.168.42.1/24 dev %s", devname);

  struct {
    struct iphdr ip;
    struct tcphdr tcp;
    unsigned char tcp_opts[20];
  } __attribute__((packed)) syn_packet = {
    .ip = {
      .ihl = sizeof(struct iphdr)/4,
      .version = 4,
      .tot_len = htons(sizeof(syn_packet)),
      .ttl = 30,
      .protocol = IPPROTO_TCP,
      /* FIXUP check */
      .saddr = IPADDR(192,168,42,2),
      .daddr = IPADDR(192,168,42,1)
    },
    .tcp = {
      .source = htons(1),
      .dest = htons(1337),
      .seq = 0x12345678,
      .doff = (sizeof(syn_packet.tcp)+sizeof(syn_packet.tcp_opts))/4,
      .syn = 1,
      .window = htons(64),
      .check = 0 /*FIXUP*/
    },
    .tcp_opts = {
      /* INVALID: trailing MD5SIG opcode after NOPs */
      1, 1, 1, 1, 1,
      1, 1, 1, 1, 1,
      1, 1, 1, 1, 1,
      1, 1, 1, 1, 19
    }
  };
  fix_ip_sum(&syn_packet.ip);
  fix_tcp_sum(&syn_packet.ip, &syn_packet.tcp);
  while (1) {
    int write_res = write(tun_fd, &syn_packet, sizeof(syn_packet));
    if (write_res != sizeof(syn_packet))
      err(1, "packet write failed");
  }
}
====================================

Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3871,11 +3871,8 @@ const u8 *tcp_parse_md5sig_option(const
 	int length = (th->doff << 2) - sizeof(*th);
 	const u8 *ptr = (const u8 *)(th + 1);
 
-	/* If the TCP option is too short, we can short cut */
-	if (length < TCPOLEN_MD5SIG)
-		return NULL;
-
-	while (length > 0) {
+	/* If not enough data remaining, we can short cut */
+	while (length >= TCPOLEN_MD5SIG) {
 		int opcode = *ptr++;
 		int opsize;
 
