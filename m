Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967366AbeBNLXn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:23:43 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38682 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967255AbeBNLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:23:41 -0500
X-Google-Smtp-Source: AH8x225X4Nf2+hAnQw48Cp61kMER/gi71lm56bw06pdg7UMDMeQeazLHIMoeud/u/EUGgxHZueX3HK97DB15+HUvMMk=
MIME-Version: 1.0
In-Reply-To: <20180209161456.18951-1-tony@atomide.com>
References: <20180209161456.18951-1-tony@atomide.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2018 13:23:40 +0200
Message-ID: <CAHp75VcSRxLZJxmqXWpAGypvZa6W2cEAiTF2muJWqdaOYu_TpA@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeirq: Add wakeup name to dedicated wake irqs
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: multipart/mixed; boundary="089e08231f04e41a8605652a57da"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--089e08231f04e41a8605652a57da
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 9, 2018 at 6:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> This makes it easy to grep :wakeup /proc/interrupts.

I used to have another patch (not published) to provide this
information via /sys/kernel/irq.

OK, here we are:


> +       namelen = strlen(dev_name(dev)) + strlen(postfix) + 1;
> +       wirq->name = kzalloc(namelen, GFP_KERNEL);

kasprintf()


-- 
With Best Regards,
Andy Shevchenko

--089e08231f04e41a8605652a57da
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-genirq-Add-wakeup-sysfs-node-to-show-IRQ-wakeup-stat.patch"
Content-Disposition: attachment;
	filename="0001-genirq-Add-wakeup-sysfs-node-to-show-IRQ-wakeup-stat.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jdmzn67w0

RnJvbSBlZjM1ZDNmZDc4OWEzMmQ4NTIxMmIyYmNiODJmNzU0YWUyNDRjZDU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxp
bnV4LmludGVsLmNvbT4KRGF0ZTogRnJpLCAxMiBNYXkgMjAxNyAyMDoxOTozMiArMDMwMApTdWJq
ZWN0OiBbUEFUQ0hdIGdlbmlycTogQWRkIHdha2V1cCBzeXNmcyBub2RlIHRvIHNob3cgSVJRIHdh
a2V1cCBzdGF0ZQoKU3VycHJpc2luZ2x5IHRoZXJlIGlzIG5vIHNpbXBsZSB3YXkgdG8gc2VlIGlm
IHRoZSBJUlEgbGluZSBpbiBxdWVzdGlvbgppcyB3YWtldXAgc291cmNlIG9yIG5vdC4KCk5vdGUg
dGhhdCB3YWtldXAgbWlnaHQgYmUgYW4gT09CIChvdXQtb2YtYmFuZCkgc291cmNlIGxpa2UgR1BJ
TyBsaW5lCndoaWNoIG1ha2VzIHRoaW5ncyBzbGlnaHRseSBtb3JlIGNvbXBsaWNhdGVkLgoKQWRk
IGEgc3lzZnMgbm9kZSB0byBjb3ZlciB0aGlzIGNhc2UuCgpTaWduZWQtb2ZmLWJ5OiBBbmR5IFNo
ZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KLS0tCiBEb2N1bWVu
dGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWtlcm5lbC1pcnEgfCAgNyArKysrKysrCiBrZXJuZWwv
aXJxL2lycWRlc2MuYyAgICAgICAgICAgICAgICAgICAgICAgfCAxNyArKysrKysrKysrKysrKysr
KwogMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1rZXJuZWwtaXJxIGIvRG9jdW1lbnRhdGlvbi9BQkkv
dGVzdGluZy9zeXNmcy1rZXJuZWwtaXJxCmluZGV4IGViMDc0YjEwMDk4Ni4uMTBhZDk5OGY5NDEx
IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWtlcm5lbC1pcnEK
KysrIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1rZXJuZWwtaXJxCkBAIC01MSwz
ICs1MSwxMCBAQCBEYXRlOgkJU2VwdGVtYmVyIDIwMTYKIEtlcm5lbFZlcnNpb246CTQuOQogQ29u
dGFjdDoJQ3JhaWcgR2FsbGVrIDxrcmFpZ0Bnb29nbGUuY29tPgogRGVzY3JpcHRpb246CVRoZSB0
eXBlIG9mIHRoZSBpbnRlcnJ1cHQuICBFaXRoZXIgdGhlIHN0cmluZyAnbGV2ZWwnIG9yICdlZGdl
Jy4KKworV2hhdDoJCS9zeXMva2VybmVsL2lycS88aXJxPi93YWtldXAKK0RhdGU6CQlKYW4gMjAx
OAorS2VybmVsVmVyc2lvbjoJNC4xNgorQ29udGFjdDoJQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXku
c2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+CitEZXNjcmlwdGlvbjoJVGhlIHdha2V1cCBzdGF0
ZSBvZiB0aGUgaW50ZXJydXB0LiBFaXRoZXIgdGhlIHN0cmluZworCQknZW5hYmxlZCcgb3IgJ2Rp
c2FibGVkJy4KZGlmZiAtLWdpdCBhL2tlcm5lbC9pcnEvaXJxZGVzYy5jIGIva2VybmVsL2lycS9p
cnFkZXNjLmMKaW5kZXggNDliNTRlOTk3OWNjLi5kOWRlZDA4OGQzMzYgMTAwNjQ0Ci0tLSBhL2tl
cm5lbC9pcnEvaXJxZGVzYy5jCisrKyBiL2tlcm5lbC9pcnEvaXJxZGVzYy5jCkBAIC0yMTAsNiAr
MjEwLDIyIEBAIHN0YXRpYyBzc2l6ZV90IHR5cGVfc2hvdyhzdHJ1Y3Qga29iamVjdCAqa29iaiwK
IH0KIElSUV9BVFRSX1JPKHR5cGUpOwogCitzdGF0aWMgc3NpemVfdCB3YWtldXBfc2hvdyhzdHJ1
Y3Qga29iamVjdCAqa29iaiwKKwkJCSAgIHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSAqYXR0ciwgY2hh
ciAqYnVmKQoreworCXN0cnVjdCBpcnFfZGVzYyAqZGVzYyA9IGNvbnRhaW5lcl9vZihrb2JqLCBz
dHJ1Y3QgaXJxX2Rlc2MsIGtvYmopOworCXNzaXplX3QgcmV0ID0gMDsKKworCXJhd19zcGluX2xv
Y2tfaXJxKCZkZXNjLT5sb2NrKTsKKwlyZXQgPSBzcHJpbnRmKGJ1ZiwgIiVzXG4iLAorCQkgICAg
ICBpcnFkX2lzX3dha2V1cF9zZXQoJmRlc2MtPmlycV9kYXRhKSA/ICJlbmFibGVkIiA6ICJkaXNh
YmxlZCIpOworCXJhd19zcGluX3VubG9ja19pcnEoJmRlc2MtPmxvY2spOworCisJcmV0dXJuIHJl
dDsKKworfQorSVJRX0FUVFJfUk8od2FrZXVwKTsKKwogc3RhdGljIHNzaXplX3QgbmFtZV9zaG93
KHN0cnVjdCBrb2JqZWN0ICprb2JqLAogCQkJIHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSAqYXR0ciwg
Y2hhciAqYnVmKQogewpAQCAtMjUzLDYgKzI2OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRl
ICppcnFfYXR0cnNbXSA9IHsKIAkmY2hpcF9uYW1lX2F0dHIuYXR0ciwKIAkmaHdpcnFfYXR0ci5h
dHRyLAogCSZ0eXBlX2F0dHIuYXR0ciwKKwkmd2FrZXVwX2F0dHIuYXR0ciwKIAkmbmFtZV9hdHRy
LmF0dHIsCiAJJmFjdGlvbnNfYXR0ci5hdHRyLAogCU5VTEwKLS0gCjIuMTUuMQoK
--089e08231f04e41a8605652a57da--
