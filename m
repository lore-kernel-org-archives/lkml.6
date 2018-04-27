Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-288473-1524837561-2-12463421217271491955
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524837560; b=HrTAVHLQel327hPUKwYp95T0LEnYFHoeO0x3zC160TdCVRRaGZ
    nc9QrGaJxdrwAOK1o6PN6iQoYfV7O0Ti3pWuNJHf2Um1v5wUcJRZhp8W7pSvLzL0
    u4O4cfQOJ0nUUaCyeIhyOgHIk7Xln+qtnDkV+YKKPu9AYzevOykV/Pefg3TXacU8
    Z9nlPv9qwqq6XqwX9kCgSlUdxvxk8h/JSkam0u6GNv2fchvZwV/Gpec7XaueZ3bm
    UOnjVWZqlTbuUjUXP8n1wT42LmyDv3WBsnrSi24C5X4h7TAAyqMG68L1FAkUAJeU
    /oTFfcnVqcjdBnqR9cwRel4Dv3WL0c6YSwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837560; bh=8CXz8A/yCNH9WNX7A2wnwaGu0VtWSF
    wFjQYiyv7TC3o=; b=agcFSkdMte/qSUfSLK+NTZxI76BLtrPHXZ4yzxCTkQSdhy
    1dMkAz61E/PnV4xxfHEalzppF72RMdLMuqxOUlmdoLFVy80WJwdzpKXYOoauH15W
    5KKq3C7CFfjcpVVPFl/rEMAnDXIa1wSjgVXdmfd+auctRjI9/5JH7hZ7Tyvc3N9e
    YoOGR69XxK5MV/40/YochkIOhAyVsReOIu63ArOTfH7UnzCdHzayCeQxdvg1+ONl
    u/ekjId7x4+fef8ZaSYEFrUvAv4U5+PzBIePvCPlHpWBSnbETJ4tIOT3YgmeRTW7
    orIlXIgAdyNEuDD69QUmKytItZmdSzXHRqwfCXPA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfOH1REYt+ZGK2shIdZa/EVG8mxA6S2WYEH6AoAOczwcHuBPrhRX1eM9AFpAOVSKj7o5Ci1g6SjCwA9rbLvSjs6NPyBhlPTwE1WkNYPafzXddj3K9FXs7
    B0Z0GQp3AEPKt3HxUqwM5uHaunVppE1F/MUj3qXOQzTobQlreAzAVHmYoUmrdkUKjqgSXB76mh1pT/SfKPAijXRCQh8pzfLUK7Hp8mLjbqFepY+3o50G56c1
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=jqAmP0lIdi3pUuq-h1kA:9
    a=cXIxkGuuh7SY9nc-:21 a=5I7q0ltCTpXhu5VR:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932882AbeD0N6b (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 09:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932861AbeD0N6Z (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 09:58:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A0E21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 12/24] tcp: dont read out-of-bounds opsize
Date: Fri, 27 Apr 2018 15:57:47 +0200
Message-Id: <20180427135632.077528650@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3731,11 +3731,8 @@ const u8 *tcp_parse_md5sig_option(const
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
 
