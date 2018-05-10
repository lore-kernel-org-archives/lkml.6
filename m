Return-Path: <songjinshi@xiaomi.com>
X-Google-Smtp-Source: AB8JxZomnmKakQkVI4qxkGdYStUzQJlq6U6PVy+nVUF4lxmUFdQ/f8BKSMxQZ/YovvEPnYGEMe1Y
ARC-Seal: i=1; a=rsa-sha256; t=1525917907; cv=none;
        d=google.com; s=arc-20160816;
        b=wLncoABVb95TKFXUYNQA6yQxy3Cyse7hgYpuW24evdNFvt1dugVJOGR3iv4tpwVuUW
         Y7UC+1Aa8vLqSIWKI/bzIJGqUKHf4NF6a20FFt1ytXTnW8+gbEMeDDJYDfZzgxlC5G7/
         K84EPEM1+rpDWCb9DH35ZSZz1k4aA4G+qJunFW7eAnEbH3elt6HY/3KQB/VwT20PmC9I
         wLyAcUkHiA2xC5J9k0QcwxFLbg/+jUCO17B7Ci9B/vNY1sTOsu32txhteSwq28itF7Yw
         Kkx6fsXV7GqZLxpAxCJ4oCbL60o2Z9O0oKmju9WYA+x8ulnsGAjietNipnt77+I+Vve/
         5yLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=OtrhE53Y9y//8llm8D43+mRSh7J8B5DSwflQ054Q+9g=;
        b=cA1x9YGzHYTsuWj+M4JjWSpWNPdR1eyX/oWrW/WIZmneNiIJ6JXl329NZ0KkwUcTz/
         rD8e3LqQqr6XbfkK9c7bN72UIJCkjVGR7iJnZyCPG5Vxy6UmG32ftLI25gcYzx+E8aP5
         ne5z56eqxdI+/c0mfnxOyokoEqANE3csp4NzzigtrAP2apuPEmR2MPLLyUG6g32OmN9Y
         bUpfwIb6Byi2Yc3SrgjAQlMAhxpD6M+sZwUMmHbv4vGl6jrRi12vaBo3SGvEIndk/ORF
         4MDI2jt8oxh0NM85LQFIPWXFzt2gFk1q6etW0TaBwnSicYZPFx+sFrS3/Kr8T84xGpST
         lXQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of songjinshi@xiaomi.com designates 207.226.244.124 as permitted sender) smtp.mailfrom=songjinshi@xiaomi.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=xiaomi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of songjinshi@xiaomi.com designates 207.226.244.124 as permitted sender) smtp.mailfrom=songjinshi@xiaomi.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=xiaomi.com
From: =?gb2312?B?y8698Mqx?= <songjinshi@xiaomi.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"maco@android.com" <maco@android.com>, "tkjos@google.com" <tkjos@google.com>,
	"arve@android.com" <arve@android.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ANDROID: binder: correct the cmd print for
 BINDER_WORK_RETURN_ERROR
Thread-Topic: [PATCH v2] ANDROID: binder: correct the cmd print for
 BINDER_WORK_RETURN_ERROR
Thread-Index: AQHT6ADYA6g3RQO53U2nCdkz2dW3FQ==
Date: Thu, 10 May 2018 02:05:03 +0000
Message-ID: <1525917903067.93656@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.237.10.121]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600040895834477297?=
X-GMAIL-MSGID: =?utf-8?q?1600040895834477297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

V2hlbiB0byBleGVjdXRlIGJpbmRlcl9zdGF0X2JyIHRoZSBlLT5jbWQgaGFzIGJlZW4gbW9kaWZ5
aW5nIGFzIEJSX09LIAppbnN0ZWFkIG9mIHRoZSBvcmlnaW5hbCByZXR1cm4gZXJyb3IgY21kLCBp
biBmYWN0IHdlIHdhbnQgdG8ga25vdyB0aGUgCm9yaWdpbmFsIHJldHVybiBlcnJvciwgc3VjaCBh
cyBCUl9ERUFEX1JFUExZIG9yIEJSX0ZBSUxFRF9SRVBMWSwgZXRjLiAKaW5zdGVhZCBvZiBhbHdh
eXMgQlJfT0ssIGluIG9yZGVyIHRvIGF2b2lkIHRoZSB2YWx1ZSBvZiB0aGUgZS0+Y21kIGlzIAph
bHdheXMgQlJfT0ssIHNvIHdlIG5lZWQgYXNzaWduIHRoZSB2YWx1ZSBvZiB0aGUgZS0+Y21kIHRv
IGNtZCBiZWZvcmUgCmUtPmNtZCA9IEJSX09LLgoKU2lnbmVkLW9mZi1ieTogc29uZ2ppbnNoaSA8
c29uZ2ppbnNoaUB4aWFvbWkuY29tPgotLS0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXIuYyB8IDMg
KystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRl
ci5jCmluZGV4IDc2NGI2M2EuLmE4NWQyNjAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYW5kcm9pZC9i
aW5kZXIuYworKysgYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMKQEAgLTM5MTcsMTAgKzM5MTcs
MTEgQEAgc3RhdGljIGludCBiaW5kZXJfdGhyZWFkX3JlYWQoc3RydWN0IGJpbmRlcl9wcm9jICpw
cm9jLAogCQkJYmluZGVyX2lubmVyX3Byb2NfdW5sb2NrKHByb2MpOwogCQkJaWYgKHB1dF91c2Vy
KGUtPmNtZCwgKHVpbnQzMl90IF9fdXNlciAqKXB0cikpCiAJCQkJcmV0dXJuIC1FRkFVTFQ7CisJ
CQljbWQgPSBlLT5jbWQ7CiAJCQllLT5jbWQgPSBCUl9PSzsKIAkJCXB0ciArPSBzaXplb2YodWlu
dDMyX3QpOwogCi0JCQliaW5kZXJfc3RhdF9icihwcm9jLCB0aHJlYWQsIGUtPmNtZCk7CisJCQli
aW5kZXJfc3RhdF9icihwcm9jLCB0aHJlYWQsIGNtZCk7CiAJCX0gYnJlYWs7CiAJCWNhc2UgQklO
REVSX1dPUktfVFJBTlNBQ1RJT05fQ09NUExFVEU6IHsKIAkJCWJpbmRlcl9pbm5lcl9wcm9jX3Vu
bG9jayhwcm9jKTsKLS0gCjEuOS4x
