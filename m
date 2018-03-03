Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-272944-1520088772-2-11215694833581922643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520088771; b=fr4xHTmr2r9Ak/zkrJXM5E/eHlayxbXwZOlf2ghJ6hQ1G6d
    6dGThz0KpiI8SNBAlTKAW0BGDhBZoJTqlQIhl8ZIfVzGERIfG0IpGJgWgGvjlfJR
    NHxP25ZciCXsMbZ+sc+DjMwkzBnpaq5sQYGR1DiOTfILqdxzsiNx1+0+lAg7awyI
    n3QgIXw/6xnVzVTYFs/dpw9iXN+OFdwYiBSO2pED7XHNNnik3h8ZIyzyK96iqDSZ
    N6HjrNKwC0YcHeQsqZFEJeQbHM1JrpMTJuinKIWV/bkuPKZUEmxd3qWoao1m8Tgg
    qSCFEtJrg+dtUU5cYscRLbMTA4Iq5wum4e2rNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:references:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1520088771; bh=HQWfmtPpb80Cbh/FJvxGAx9pt95ZEM7rjSbPNkR6uOE=; b=N
    KJrUEOK2gLnJMy37CSqbZgwqWfojZoNmiTyL+EQLdv3cbXwnHtLU24Zzm6/h2ptS
    ikn6hfLxMHp2/A5zfw/93yZvvmSVtZ6fF0DfXQNrblW7iYEOoyaMzNAb7DbADNy5
    ZCPwEsSOby0gOH1XhIwGUcAGAT3TgQtwGu68tc287+E1mWuiwnHZmIEtNEA8OITp
    XzoN+eg5kcqUdCidGwSQJie1zefoAD78rHvcOTliQT2/a+ZZwq1VLHsT8esRszhb
    9ZgVDuM9qfGpPIC6M6g38mlGWXngb1dvYj+0PFB5eDjsDt8INXlqApLPU8z44Xsk
    5qTD9mz6u7wJj6MCsMR6Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=V6CuxpZn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=V6CuxpZn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=V6CuxpZn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=V6CuxpZn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 234DF602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Query:Regarding object poison overwritten in binder_transaction
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
To: =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
 Riley Andrews <riandrews@android.com>, devel@driverdev.osuosl.org
References: <4d2b6014-ea76-b489-fdde-2e058e2fac4d@codeaurora.org>
Message-ID: <760538e9-dd50-6cd3-1268-bb535eb363d0@codeaurora.org>
Date: Sat, 3 Mar 2018 20:22:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4d2b6014-ea76-b489-fdde-2e058e2fac4d@codeaurora.org>
Content-Language: en-US
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SEkgLAoKSXMgdGhlcmUgYW55IGtub3duIGlzc3VlIG9mIHNsYWIgcG9pc29uaW5nIGluIGJpbmRl
cl90cmFuc2FjdGlvbiB2YXJpYWJsZSBvbiBrZXJuZWwgNC45LAoKIMKgaXQgc2VlbXMgb3duZXIg
dmFyaWFibGUgb2Ygc3BpbmxvY2sgaXMKZ2V0dGluZyBjb3JydXB0ZWQod2hpY2ggaXMgbGFzdCA4
dGggYnl0ZSBvZiBiaW5kZXJfdHJhbnNhY3Rpb24gc3RydWN0KS4KCiDCoMKgIDM2OC40MjM0NjI6
wqDCoCA8Mj4gWzxmZmZmZmY5MThlYzMxNzdjPl0gcHJpbnRfdHJhaWxlcisweDEzYy8weDIxNAoK
IMKgwqAgMzY4LjQyODk5ODrCoMKgIDwyPiBbPGZmZmZmZjkxOGVjMzE5M2M+XSBjaGVja19ieXRl
c19hbmRfcmVwb3J0KzB4ZTgvMHhmYwoKIMKgwqAgMzY4LjQzNTE0NDrCoMKgIDwyPiBbPGZmZmZm
ZjkxOGVjMzFkOGM+XSBjaGVja19vYmplY3QrMHgyNDgvMHgyODAKCiDCoMKgIDM2OC40NDA1OTI6
wqDCoCA8Mj4gWzxmZmZmZmY5MThlYzMxZjBjPl0gYWxsb2NfZGVidWdfcHJvY2Vzc2luZysweDE0
OC8weDFhMAoKIMKgwqAgMzY4LjQ0NjkxMzrCoMKgIDwyPiBbPGZmZmZmZjkxOGVjMzMzZDA+XSBf
X19zbGFiX2FsbG9jLmNvbnN0cHJvcC43MisweDY1NC8weDY5MAoKIMKgwqAgMzY4LjQ1MzU4NjrC
oMKgIDwyPiBbPGZmZmZmZjkxOGVjMzM0NjQ+XSBfX3NsYWJfYWxsb2MuaXNyYS42OC5jb25zdHBy
b3AuNzErMHg1OC8weDk4CgogwqDCoCAzNjguNDYwNjkzOsKgwqAgPDI+IFs8ZmZmZmZmOTE4ZWMz
MzhmYz5dIGttZW1fY2FjaGVfYWxsb2NfdHJhY2UrMHgxOTgvMHgyYzQKCiDCoMKgIDM2OC40Njcw
MTE6wqDCoCA8Mj4gWzxmZmZmZmY5MThmN2FlMjRjPl0gYmluZGVyX3RyYW5zYWN0aW9uKzB4Y2I4
LzB4MjQ0YwoKIMKgwqAgMzY4LjQ3MzA2NTrCoMKgIDwyPiBbPGZmZmZmZjkxOGY3YjAzYjg+XSBi
aW5kZXJfdGhyZWFkX3dyaXRlKzB4OWQ4LzB4MTQxMAoKIMKgwqAgMzY4LjQ3OTIwNjrCoMKgIDwy
PiBbPGZmZmZmZjkxOGY3YjBmMjA+XSBiaW5kZXJfaW9jdGxfd3JpdGVfcmVhZCsweDEzMC8weDM3
MAoKIMKgwqAgMzY4LjQ4NTYxNTrCoMKgIDwyPiBbPGZmZmZmZjkxOGY3YjE2YjA+XSBiaW5kZXJf
aW9jdGwrMHg1NTAvMHg3ZGMKCiDCoMKgIDM2OC40OTEwNjU6wqDCoCA8Mj4gWzxmZmZmZmY5MThl
YzVhYzBjPl0gZG9fdmZzX2lvY3RsKzB4Y2MvMHg4ODgKCiDCoMKgIDM2OC40OTY0MjQ6wqDCoCA8
Mj4gWzxmZmZmZmY5MThlYzViNDU4Pl0gU3lTX2lvY3RsKzB4OTAvMHhhNAoKIMKgwqAgMzY4LjUw
MTQzMDrCoMKgIDwyPiBbPGZmZmZmZjkxOGVhODM3NzA+XSBlbDBfc3ZjX25ha2VkKzB4MjQvMHgy
OAoKIMKgwqAgMzY4LjUwNjc5ODrCoMKgIDw2PiBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzog
b2JqZWN0IHBvaXNvbiBvdmVyd3JpdHRlbgoKIMKgwqAgMzY4LjI4Nzc0MzrCoMKgIDw2PiBPYmpl
Y3QgZmZmZmZmYzVhMDY5MmUyMDogNmIgNmIgNmIgNmIgNmIgNmIgNmIgNmIgNmIgNmIgNmIgNmIg
NmIgNmIgNmIgNmLCoCBra2tra2tra2tra2tra2trCgogwqDCoCAzNjguMjk3MTE3OsKgwqAgPDY+
IE9iamVjdCBmZmZmZmZjNWEwNjkyZTMwOiA2YiA2YiA2YiA2YiA2YiA2YiA2YiA2YiA2YiA2YiA2
YiA2YiA2YiA2YiA2YiA2YsKgIGtra2tra2tra2tra2tra2sKCiDCoMKgIDM2OC4zMDY0ODc6wqDC
oCA8Nj4gT2JqZWN0IGZmZmZmZmM1YTA2OTJlNDA6IDZiIDZiIDZiIDZiIDZiIDZiIDZiIDZiIDZi
IDZiIDZiIDZiIDZiIDZiIDZiIDZiwqAga2tra2tra2tra2tra2trawoKIMKgwqAgMzY4LjMxNTg2
NjrCoMKgIDw2PiBPYmplY3QgZmZmZmZmYzVhMDY5MmU1MDogNmIgNmIgNmIgNmIgNmIgNmIgNmIg
NmIgNmIgNmIgNmIgNmIgNmIgNmIgNmIgNmLCoCBra2tra2tra2tra2tra2trCgogwqDCoCAzNjgu
MzI1MjQxOsKgwqAgPDY+IE9iamVjdCBmZmZmZmZjNWEwNjkyZTYwOiA2YiA2YiA2YiA2YiA2YiA2
YiA2YiA2YiA2YiA2YiA2YiA2YiA2YiA2YiA2YiA2YsKgIGtra2tra2tra2tra2tra2sKCiDCoMKg
IDM2OC4zMzQ2MTg6wqDCoCA8Nj4gT2JqZWN0IGZmZmZmZmM1YTA2OTJlNzA6IDZiIDZiIDZiIDZi
IDZiIDZiIDZiIDZiIDY3IDZiIDZiIDZiIDZiIDZiIDZiIGE1wqAga2tra2tra2tna2tra2trLsKg
wqAgIGhlcmUgaXQgaXMgY29ycnVwdGVkKHNlZW1zIHdyaXRlIGFmdGVyIGZyZWUgY2FzZSkKCgog
wqDCoCAzNjguMzQzOTk3OsKgwqAgPDY+IFJlZHpvbmUgZmZmZmZmYzVhMDY5MmU4MDogYmIgYmIg
YmIgYmIgYmIgYmIgYmIgYmLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAuLi4uLi4uLgoKIMKgwqAgMzY4LjM1Mjc1NTrCoMKgIDw2PiBQYWRkaW5nIGZm
ZmZmZmM1YTA2OTJmYzA6IDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVh
IDVhIDVhwqAgWlpaWlpaWlpaWlpaWlpaWgoKIMKgwqAgMzY4LjM2MjIxNTrCoMKgIDw2PiBQYWRk
aW5nIGZmZmZmZmM1YTA2OTJmZDA6IDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVh
IDVhIDVhIDVhIDVhwqAgWlpaWlpaWlpaWlpaWlpaWgoKIMKgwqAgMzY4LjM3MTY4MTrCoMKgIDw2
PiBQYWRkaW5nIGZmZmZmZmM1YTA2OTJmZTA6IDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVh
IDVhIDVhIDVhIDVhIDVhIDVhwqAgWlpaWlpaWlpaWlpaWlpaWgoKIMKgwqAgMzY4LjM4MTE0NjrC
oMKgIDw2PiBQYWRkaW5nIGZmZmZmZmM1YTA2OTJmZjA6IDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVh
IDVhIDVhIDVhIDVhIDVhIDVhIDVhIDVhwqAgWlpaWlpaWlpaWlpaWlpaWgoKUmVnYXJkcwoKR2F1
cmF2CgotLSAKClF1YWxjb21tIEluZGlhIFByaXZhdGUgTGltaXRlZCwgb24gYmVoYWxmIG9mIFF1
YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIGlzIGEgbWVtYmVyIG9mIHRoZSBDb2RlIEF1
cm9yYSBGb3J1bSwKCmEgTGludXggRm91bmRhdGlvbiBDb2xsYWJvcmF0aXZlIFByb2plY3QuCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWls
aW5nIGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2Lmxp
bnV4ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
