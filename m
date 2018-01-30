Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeA3UZn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:25:43 -0500
Received: from mx0a-00191d01.pphosted.com ([67.231.149.140]:37270 "EHLO
        mx0a-00191d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751728AbeA3UZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:25:41 -0500
From: "Brown, Nicholas" <nb930b@intl.att.com>
To: "joe@perches.com" <joe@perches.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "nickbroon@gmail.com" <nickbroon@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: warn if changed lines exceeds a maximum size
Thread-Topic: [PATCH] checkpatch: warn if changed lines exceeds a maximum
 size
Thread-Index: AQHTmeMGAPsYZkfslkm5Wnly+K55WaOMldQAgAAf4ICAAA/2gIAAAlYAgAAVDAA=
Date: Tue, 30 Jan 2018 20:25:05 +0000
Message-ID: <1517343904.3063.33.camel@intl.att.com>
References: <1517335455.3063.28.camel@intl.att.com>
         <20180130190123.9669-1-nick.brown@att.com>
         <1517339384.765.31.camel@perches.com>
In-Reply-To: <1517339384.765.31.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.156.48.128]
Content-Type: text/plain; charset="utf-8"
Content-ID: <79609E0CAA28EE4A9CDD30519D347531@intl.att.com>
MIME-Version: 1.0
X-RSA-Inspected: yes
X-RSA-Classifications: public
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=710 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1801300246
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0UKPmXC032427

On Tue, 2018-01-30 at 11:09 -0800, Joe Perches wrote:
> On Tue, 2018-01-30 at 19:01 +0000, Nicholas Brown wrote:
> > Changed lines is the total of inserted and deleted lines.
> > By default there is no limit, --max-changed-lines may be used to
> > set a
> > value. Some users may wish to encourage that patches are split into
> > smaller parts using this.
> > See Documentation/process/submitting-patches.rst#split-changes
> 
> Still whitespace damaged.
> Indentations use tabs not 2 spaces.

Hopefully editor set correctly now, so follow-up should fix this.

> 
> and another issue below
> 
> > 
> > @@ -2233,6 +2239,14 @@ sub process {
> >  
> >  		push(@fixed, $rawline) if ($fix);
> >  
> > +		if ($rawline=~/^\+/) {
> > +		  $inserted_lines_total++
> 
> This counts patch header blocks with \+\+\+

Good catch. Will fix.

> 
> > +		}
> > +
> > +		if ($rawline=~/^-/) {
> > +		  $deleted_lines_total++
> > +		}
> 
> and \-\-\-

Ditto.

Thanks, Nick
