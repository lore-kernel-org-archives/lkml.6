Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654586-1521695545-2-682860820232848615
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8', plain='UTF-8', plain='UTF-8'
X-Attached: v4.4-0001-SMB3-Validate-negotiate-request-must-always-be-signe.patch
X-Attached: v4.4-0002-CIFS-Enable-encryption-during-session-setup-phase.patch
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521695544; b=BEkR7sf29rUrPVTXYdbMLVgnjKGREmfGHC0+gGjmQ2q5KCr
    h8Zlsl+LzF/qn9dRWoYpKLpZ++Z2D62YE7Hrdtzspnd+wgkYJSIQUn9ABAARvZ0H
    mdovR3ydjWUy+KfaapXPoaz+/ayrRpWnDm213xVrk2aONMptRXJb1f/HC+Pu+wsQ
    Kh1h3yperentuHZei/Gecqm6KJpKxEhtRiDrabAWxsBgAC35MExh1WfBnKFlCCrM
    M0CKpyCNrVI8EGIt1JDyFTqz9bcV83KHjhGIe+zUxvdNb6AghoA9zBigi3sRNGtM
    Q0NWd9gkUe7qZ3TMInCC3dMFKWoAboaVp8a8XGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1521695544; bh=7M5lA9IWBS4Sw9dZlsC6h9cBRZcMb3fdhe05rC
    ZmWTg=; b=PVJPMgyP4ii2winFeP57+pXS9dCoVHc7TD+QsKt3iNhKg2zlXO2DYI
    e43X6euVz/DzpRmuagtwVyGYn3lOLbU6HnIhrM5NOYlWLethDPdkUcjx71gDAgkP
    6wzZf92u6rjDg1jhWXzlVIsIWlLh2OWLxjMLqVzzOAjy7n7Xc7hj00qAeUbUW7Jz
    ejmE+gCGPFHy9qSteQZPY7dkEGVFarS7MZC/bhgXQotm9fKXgkJyEKNppdOjuuPi
    cPmgR20tEOTtXW4j9vWg2SO2evOnJmn9hV42QCOnbsxVdb7ROybrFLzaWaBM8Miw
    kxiu57l6I+nyzHxeaDAGsYigLOpVitYA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=csail.mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csail.mit.edu header.result=pass header_org.domain=mit.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=csail.mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csail.mit.edu header.result=pass header_org.domain=mit.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeCVFMS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 01:12:18 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:47031 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751948AbeCVFMQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 01:12:16 -0400
Subject: Re: [PATCH 4.13 28/43] SMB3: Validate negotiate request must always
 be signed
To: Steve French <smfrench@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Backlund <tmb@mageia.org>,
        =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovskiy <pshilov@microsoft.com>,
        CIFS <linux-cifs@vger.kernel.org>
References: <28ffc363-5140-5685-d288-6e3dc07c6369@csail.mit.edu>
 <20180227085428.GA16879@kroah.com>
 <b20cbd94-ce9b-cb2c-dc95-a6821376823f@csail.mit.edu>
 <20180227124050.GB31888@kroah.com>
 <6bca5a97-f581-86b8-12ad-77147619d519@csail.mit.edu>
 <CAH2r5mt91WGHDk-+LP4EBTEfAOmrY2k6_X7KKjc0D+LcDCfxRw@mail.gmail.com>
 <309db6c4-7e21-bfbe-44d4-eb41f5516d5e@csail.mit.edu>
 <CAH2r5muUfsZsqaBqkAfi_dXRheib+7DN=VSsbGcV22C2MdJaGw@mail.gmail.com>
 <20180313092133.GA13325@kroah.com>
 <CAH2r5mvmiTaC4W=LAaOvWv6xGEMce957c+u+Af6wNgxudbO3_w@mail.gmail.com>
 <20180316133241.GC11397@kroah.com>
 <CAH2r5mvYxpr_0CPZNiNJTGhFNaM06w-EoTT7WS8oVjVZq8HCCw@mail.gmail.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <6745f869-e249-a891-8d76-79f2830dd57f@csail.mit.edu>
Date: Wed, 21 Mar 2018 22:12:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAH2r5mvYxpr_0CPZNiNJTGhFNaM06w-EoTT7WS8oVjVZq8HCCw@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------D6FB28CE7AF7DFC86731D754"
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------D6FB28CE7AF7DFC86731D754
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 3/21/18 7:02 PM, Steve French wrote:
> Found a patch which solves the dependency issue.  In my testing (on
> 4.9, with Windows 2016, and also to Samba) as Pavel suggested this
> appears to fix the problem, but I will let Srivatsa confirm that it
> also fixes it for him.  The two attached patches for 4.9 should work.
> 

Indeed, those two patches fix the problem for me on 4.9. Thanks a lot
Steve, Pavel and Aurelien for all your efforts in fixing this!

I was also interested in getting this fixed on 4.4, so I modified the
patches to apply on 4.4.88 and verified that they fix the mount
failure. I have attached my patches for 4.4 with this mail.

Steve, Pavel, could you kindly double-check the second patch for 4.4,
especially around the keygen_exit error path?

Thank you very much!

Regards,
Srivatsa
VMware Photon OS

--------------D6FB28CE7AF7DFC86731D754
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="v4.4-0001-SMB3-Validate-negotiate-request-must-always-be-signe.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="v4.4-0001-SMB3-Validate-negotiate-request-must-always-be-sig";
 filename*1="ne.patch"

RnJvbSBhMDFhN2RmYjYwZTJkNTQyMWE0ODdhN2I4MWZkOGExYmY3MmQ5NmQ0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHNtZnJlbmNoQGdtYWlsLmNv
bT4KRGF0ZTogU3VuLCAxMSBNYXIgMjAxOCAyMDowMDoyNyAtMDcwMApTdWJqZWN0OiBbUEFU
Q0ggMS8yXSBTTUIzOiBWYWxpZGF0ZSBuZWdvdGlhdGUgcmVxdWVzdCBtdXN0IGFsd2F5cyBi
ZSBzaWduZWQKCmNvbW1pdCA0NTg3ZWVlMDRlMmFjN2FjM2FjOWZhMmJjMTY0ZmI2ZTU0OGY5
OWNkIHVwc3RyZWFtLgoKQWNjb3JkaW5nIHRvIE1TLVNNQjIgMy4yLjU1IHZhbGlkYXRlX25l
Z290aWF0ZSByZXF1ZXN0IG11c3QKYWx3YXlzIGJlIHNpZ25lZC4gU29tZSBXaW5kb3dzIGNh
biBmYWlsIHRoZSByZXF1ZXN0IGlmIHlvdSBzZW5kIGl0IHVuc2lnbmVkCgpTZWUga2VybmVs
IGJ1Z3ppbGxhIGJ1ZyAxOTczMTEKClsgRml4ZWQgdXAgZm9yIGtlcm5lbCB2ZXJzaW9uIDQu
NCBdCgpDQzogU3RhYmxlIDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgpBY2tlZC1ieTogUm9u
bmllIFNhaGxiZXJnIDxsc2FobGJlci5yZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGV2
ZSBGcmVuY2ggPHNtZnJlbmNoQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU3JpdmF0c2Eg
Uy4gQmhhdCA8c3JpdmF0c2FAY3NhaWwubWl0LmVkdT4KLS0tCiBmcy9jaWZzL3NtYjJwZHUu
YyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZnMvY2lmcy9zbWIycGR1LmMgYi9mcy9jaWZzL3NtYjJwZHUuYwppbmRleCA4NDYxNGE1
Li42ZGFlNWI4IDEwMDY0NAotLS0gYS9mcy9jaWZzL3NtYjJwZHUuYworKysgYi9mcy9jaWZz
L3NtYjJwZHUuYwpAQCAtMTU1OCw2ICsxNTU4LDkgQEAgU01CMl9pb2N0bChjb25zdCB1bnNp
Z25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uLCB1NjQgcGVyc2lzdGVudF9m
aWQsCiAJfSBlbHNlCiAJCWlvdlswXS5pb3ZfbGVuID0gZ2V0X3JmYzEwMDJfbGVuZ3RoKHJl
cSkgKyA0OwogCisJLyogdmFsaWRhdGUgbmVnb3RpYXRlIHJlcXVlc3QgbXVzdCBiZSBzaWdu
ZWQgLSBzZWUgTVMtU01CMiAzLjIuNS41ICovCisJaWYgKG9wY29kZSA9PSBGU0NUTF9WQUxJ
REFURV9ORUdPVElBVEVfSU5GTykKKwkJcmVxLT5oZHIuRmxhZ3MgfD0gU01CMl9GTEFHU19T
SUdORUQ7CiAKIAlyYyA9IFNlbmRSZWNlaXZlMih4aWQsIHNlcywgaW92LCBudW1faW92ZWNz
LCAmcmVzcF9idWZ0eXBlLCAwKTsKIAlyc3AgPSAoc3RydWN0IHNtYjJfaW9jdGxfcnNwICop
aW92WzBdLmlvdl9iYXNlOwotLSAKMi43LjQKCg==
--------------D6FB28CE7AF7DFC86731D754
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="v4.4-0002-CIFS-Enable-encryption-during-session-setup-phase.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="v4.4-0002-CIFS-Enable-encryption-during-session-setup-phase.";
 filename*1="patch"

RnJvbSBkMDE3OGQ4ZjA5NmIyOWE4ODkxNDc4NzI3NGJkYzhlZTgzMzRhYjA3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBTaGlsb3Zza3kgPHBzaGlsb3ZAbWljcm9z
b2Z0LmNvbT4KRGF0ZTogTW9uLCA3IE5vdiAyMDE2IDE4OjIwOjUwIC0wODAwClN1YmplY3Q6
IFtQQVRDSCAyLzJdIENJRlM6IEVuYWJsZSBlbmNyeXB0aW9uIGR1cmluZyBzZXNzaW9uIHNl
dHVwIHBoYXNlCgpjb21taXQgY2FiZmIzNjgwZjc4OTgxZDI2YzA3OGEyNmU1Yzc0ODUzMTI1
N2ViYiB1cHN0cmVhbS4KCkluIG9yZGVyIHRvIGFsbG93IGVuY3J5cHRpb24gb24gU01CIGNv
bm5lY3Rpb24gd2UgbmVlZCB0byBleGNoYW5nZQphIHNlc3Npb24ga2V5IGFuZCBnZW5lcmF0
ZSBlbmNyeXB0aW9uIGFuZCBkZWNyeXB0aW9uIGtleXMuCgpbIEZpeGVkIHVwIGZvciBrZXJu
ZWwgdmVyc2lvbiA0LjQgXQoKU2lnbmVkLW9mZi1ieTogUGF2ZWwgU2hpbG92c2t5IDxwc2hp
bG92QG1pY3Jvc29mdC5jb20+ClNpZ25lZC1vZmYtYnk6IFNyaXZhdHNhIFMuIEJoYXQgPHNy
aXZhdHNhQGNzYWlsLm1pdC5lZHU+Ci0tLQogZnMvY2lmcy9zZXNzLmMgICAgfCAyMiArKysr
KysrKysrLS0tLS0tLS0tLS0tCiBmcy9jaWZzL3NtYjJwZHUuYyB8ICA4ICstLS0tLS0tCiAy
IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2ZzL2NpZnMvc2Vzcy5jIGIvZnMvY2lmcy9zZXNzLmMKaW5kZXggZTg4ZmZl
MS4uYTAzNWQxYSAxMDA2NDQKLS0tIGEvZnMvY2lmcy9zZXNzLmMKKysrIGIvZnMvY2lmcy9z
ZXNzLmMKQEAgLTM0NCwxMyArMzQ0LDEyIEBAIHZvaWQgYnVpbGRfbnRsbXNzcF9uZWdvdGlh
dGVfYmxvYih1bnNpZ25lZCBjaGFyICpwYnVmZmVyLAogCS8qIEJCIGlzIE5UTE1WMiBzZXNz
aW9uIHNlY3VyaXR5IGZvcm1hdCBlYXNpZXIgdG8gdXNlIGhlcmU/ICovCiAJZmxhZ3MgPSBO
VExNU1NQX05FR09USUFURV81NiB8CU5UTE1TU1BfUkVRVUVTVF9UQVJHRVQgfAogCQlOVExN
U1NQX05FR09USUFURV8xMjggfCBOVExNU1NQX05FR09USUFURV9VTklDT0RFIHwKLQkJTlRM
TVNTUF9ORUdPVElBVEVfTlRMTSB8IE5UTE1TU1BfTkVHT1RJQVRFX0VYVEVOREVEX1NFQzsK
LQlpZiAoc2VzLT5zZXJ2ZXItPnNpZ24pIHsKKwkJTlRMTVNTUF9ORUdPVElBVEVfTlRMTSB8
IE5UTE1TU1BfTkVHT1RJQVRFX0VYVEVOREVEX1NFQyB8CisJCU5UTE1TU1BfTkVHT1RJQVRF
X1NFQUw7CisJaWYgKHNlcy0+c2VydmVyLT5zaWduKQogCQlmbGFncyB8PSBOVExNU1NQX05F
R09USUFURV9TSUdOOwotCQlpZiAoIXNlcy0+c2VydmVyLT5zZXNzaW9uX2VzdGFiIHx8Ci0J
CQkJc2VzLT5udGxtc3NwLT5zZXNza2V5X3Blcl9zbWJzZXNzKQotCQkJZmxhZ3MgfD0gTlRM
TVNTUF9ORUdPVElBVEVfS0VZX1hDSDsKLQl9CisJaWYgKCFzZXMtPnNlcnZlci0+c2Vzc2lv
bl9lc3RhYiB8fCBzZXMtPm50bG1zc3AtPnNlc3NrZXlfcGVyX3NtYnNlc3MpCisJCWZsYWdz
IHw9IE5UTE1TU1BfTkVHT1RJQVRFX0tFWV9YQ0g7CiAKIAlzZWNfYmxvYi0+TmVnb3RpYXRl
RmxhZ3MgPSBjcHVfdG9fbGUzMihmbGFncyk7CiAKQEAgLTQwNywxMyArNDA2LDEyIEBAIGlu
dCBidWlsZF9udGxtc3NwX2F1dGhfYmxvYih1bnNpZ25lZCBjaGFyICoqcGJ1ZmZlciwKIAlm
bGFncyA9IE5UTE1TU1BfTkVHT1RJQVRFXzU2IHwKIAkJTlRMTVNTUF9SRVFVRVNUX1RBUkdF
VCB8IE5UTE1TU1BfTkVHT1RJQVRFX1RBUkdFVF9JTkZPIHwKIAkJTlRMTVNTUF9ORUdPVElB
VEVfMTI4IHwgTlRMTVNTUF9ORUdPVElBVEVfVU5JQ09ERSB8Ci0JCU5UTE1TU1BfTkVHT1RJ
QVRFX05UTE0gfCBOVExNU1NQX05FR09USUFURV9FWFRFTkRFRF9TRUM7Ci0JaWYgKHNlcy0+
c2VydmVyLT5zaWduKSB7CisJCU5UTE1TU1BfTkVHT1RJQVRFX05UTE0gfCBOVExNU1NQX05F
R09USUFURV9FWFRFTkRFRF9TRUMgfAorCQlOVExNU1NQX05FR09USUFURV9TRUFMOworCWlm
IChzZXMtPnNlcnZlci0+c2lnbikKIAkJZmxhZ3MgfD0gTlRMTVNTUF9ORUdPVElBVEVfU0lH
TjsKLQkJaWYgKCFzZXMtPnNlcnZlci0+c2Vzc2lvbl9lc3RhYiB8fAotCQkJCXNlcy0+bnRs
bXNzcC0+c2Vzc2tleV9wZXJfc21ic2VzcykKLQkJCWZsYWdzIHw9IE5UTE1TU1BfTkVHT1RJ
QVRFX0tFWV9YQ0g7Ci0JfQorCWlmICghc2VzLT5zZXJ2ZXItPnNlc3Npb25fZXN0YWIgfHwg
c2VzLT5udGxtc3NwLT5zZXNza2V5X3Blcl9zbWJzZXNzKQorCQlmbGFncyB8PSBOVExNU1NQ
X05FR09USUFURV9LRVlfWENIOwogCiAJdG1wID0gKnBidWZmZXIgKyBzaXplb2YoQVVUSEVO
VElDQVRFX01FU1NBR0UpOwogCXNlY19ibG9iLT5OZWdvdGlhdGVGbGFncyA9IGNwdV90b19s
ZTMyKGZsYWdzKTsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvc21iMnBkdS5jIGIvZnMvY2lmcy9z
bWIycGR1LmMKaW5kZXggNmRhZTViOC4uMzNiMWJjMiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9z
bWIycGR1LmMKKysrIGIvZnMvY2lmcy9zbWIycGR1LmMKQEAgLTgzMiwxMCArODMyLDggQEAg
c3NldHVwX2V4aXQ6CiAKIAlpZiAoIXJjKSB7CiAJCW11dGV4X2xvY2soJnNlcnZlci0+c3J2
X211dGV4KTsKLQkJaWYgKHNlcnZlci0+c2lnbiAmJiBzZXJ2ZXItPm9wcy0+Z2VuZXJhdGVf
c2lnbmluZ2tleSkgeworCQlpZiAoc2VydmVyLT5vcHMtPmdlbmVyYXRlX3NpZ25pbmdrZXkp
IHsKIAkJCXJjID0gc2VydmVyLT5vcHMtPmdlbmVyYXRlX3NpZ25pbmdrZXkoc2VzKTsKLQkJ
CWtmcmVlKHNlcy0+YXV0aF9rZXkucmVzcG9uc2UpOwotCQkJc2VzLT5hdXRoX2tleS5yZXNw
b25zZSA9IE5VTEw7CiAJCQlpZiAocmMpIHsKIAkJCQljaWZzX2RiZyhGWUksCiAJCQkJCSJT
TUIzIHNlc3Npb24ga2V5IGdlbmVyYXRpb24gZmFpbGVkXG4iKTsKQEAgLTg1NywxMCArODU1
LDYgQEAgc3NldHVwX2V4aXQ6CiAJfQogCiBrZXlnZW5fZXhpdDoKLQlpZiAoIXNlcnZlci0+
c2lnbikgewotCQlrZnJlZShzZXMtPmF1dGhfa2V5LnJlc3BvbnNlKTsKLQkJc2VzLT5hdXRo
X2tleS5yZXNwb25zZSA9IE5VTEw7Ci0JfQogCWlmIChzcG5lZ29fa2V5KSB7CiAJCWtleV9p
bnZhbGlkYXRlKHNwbmVnb19rZXkpOwogCQlrZXlfcHV0KHNwbmVnb19rZXkpOwotLSAKMi43
LjQKCg==
--------------D6FB28CE7AF7DFC86731D754--
