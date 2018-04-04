Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeDDQx1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:53:27 -0400
Received: from mail-by2nam03on0077.outbound.protection.outlook.com ([104.47.42.77]:40555
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751389AbeDDQxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:53:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Wed, 4 Apr 2018 19:53:04 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot+6887cbb011c8054e8a3d@syzkaller.appspotmail.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, syzkaller-bugs@googlegroups.com,
        noamca@mellanox.com, linux@rasmusvillemoes.dk, mawilcox@microsoft.com,
        mchehab@kernel.org, akpm@linux-foundation.org
Subject: Re: INFO: rcu detected stall in bitmap_parselist
Message-ID: <20180404165304.fkclobbpqd4itwta@yury-thinkpad>
References: <000000000000edc3690568cc95eb@google.com>
 <f1a0af0d-44c5-e938-b48f-0bace885f0a2@I-love.SAKURA.ne.jp>
 <20180404154136.p7aeye7657q466sq@yury-thinkpad>
 <201804050058.EIB64593.LtSFQHFJOMOVFO@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804050058.EIB64593.LtSFQHFJOMOVFO@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [58.11.97.202]
X-ClientProxiedBy: VI1P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::21) To BN6PR07MB2897.namprd07.prod.outlook.com
 (2603:10b6:404:41::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3de094ac-e444-4896-66b0-08d59a4c9326
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2897;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;3:K8e7ZNheYl0lObhCSuCL45MjEpxfkA636qpDUUJs0c4vj3VCt0dmurnorPWJVqmc98UVHbNTZKk+kHG1KBmhzWX3Fw8MtwTwN5EnFJEZVO3QVsZ7f+woYcVM/S870NnwLNa0cEZapYot402snoDouMvtdmmFZi3ld4mH1mx1nePlmO8uOBUWqItKVHOitY6K+cETfd8gvuCbsoXaivZymo0/X+VwyE5GeVl6EpV9NiwtzCDHNFEDVR6ZLoGEXFy8;25:WdXA8bvMP8dc8ym7OOHrPmF5aHZjJ8bVdTZrQJT94tDtCaXk9m7qUzFaQC4TXF3b154ebiU1F2P1GBCFN4dQGBgb5+DHEG58nkh1esLoPcJZgE6IvGDFsNcuLduyPwKr1h6sc6SsSSpLzcWouYVmVkizXSBL3Lj68979H9eQrjWP89w40ISe2lsTvFgJSmoMTTPOOTAZR/qATjj4+MCij7GmiJdXmtOx2o4o9m9YSO77F5dZA2ctWpA9LcuLOiZDrOfzrIosOkbXlMJOSoNYrxJ3+mVmPTUDruWx6lDFSrO/nW0ezHT/vE8S8o9f7S1P95NrevbDKtaYy6hT7aX0qQ==;31:WGF0ULGAeU4n2jeae9lOW8BHH2j6e/AhNGokf8xQWLAaRpc/HWiho3Jh4pOla7hFDJmD8BkbNzvkIfRkKBlhNBpPCOk/EPLoYkqKbKZhiZ6hyEpTj9iHrzOyQPdrGNivch/47CoeCFQXaz4APhm4LvLCELem5LTr8jbQRr5isgb1RvTxHOCIHHgZ/Qt3DJ0RwREBtgboLZRdHkGsiIrTXUX2S7fhmP7Z1TQYEE264Fs=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2897:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;20:fYSW8oyhIqWnGdc2YN80Ask2MHZG3HZ+527sh9DxvclYv/XO2i9/x4rXsLtg73ODNfo0Maei0u/O5Ca3gLv5CxkJKu1pr3Q1JjvqS/e6lqtSoUh/W4v6W1w4CKCQbB7iuaLkR2nnfoQausziB34Rer8leQujYquUFiz2C2xd4ZT1orYH9z9du2M1S9THDsne1zlxW8LWt7PbaVqrTj1jHYvwZda1JSPLTpnlV9+WJXFfbcy3iClg+stRYGH8RLpxv6mhscSzNEmxrYU2UxlOAAP3gAkDLAoeDapF5QaWG0P2GOpjHogdaGrhLnvHvRvzhjPBwgZpLdtDKhTyzTe4xONnn2o2Mm4abI4mDRa7XfBUseE0PynruNvHUI8w2R6MWYHdLHHkVmkEmSo1qqA/S4aeoaqOK6IalDp2QR01z/7nBmwlGxYy2SM422hOs2UYh6untWiUBFDcqNDUmI4txVJisJV1WVY1sSMs3YQLDydVaN8jvNIO9mwPXERohvXj3Iru0b6keRrP38r4w2V5N+cdpu5AU5hmyTXUnFnsXsCRqAIXzw5MBGG02+MICF0n7GtB9ssGr20rZkFO9o3CxXPiVavL3/v9Ac8p47ytTl4=;4:PNArcKJr0dkm+Gft9hvQ742Gn038f5VwCInxmh+DSTtjpeXJfj1NTO5ZFDVSs1BIyD4lTHIXk5vp0ZFsK6XWPAkUs0EN2mtKyjsGKgWMkICI0iHPhMVUc3KfExm8A+7eDOQBBEuQb6gyXcTkJuan1V5obvjtvUFQlNWOQDnybGT1MH8nclK/2kV56lQ1ZTeka8yAxytnjGrWGsvYvSqBdVkEBO9G4b2mwHu7dxXz7p8hrqD0GuZsupYkik4NNHcZy4rhYln5PV2Ernmt2pWwnQN4kPdVBxE1+5ku1v6uBrCTE0EQX3dsG3JeIsz5OQWg
X-Microsoft-Antispam-PRVS: <BN6PR07MB2897D8A2F7DA63C3ADBBE2F3E3A40@BN6PR07MB2897.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(274141268393343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR07MB2897;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2897;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39380400002)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(57704003)(51914003)(446003)(476003)(186003)(16526019)(26005)(6496006)(58126008)(956004)(76176011)(52116002)(33896004)(33716001)(11346002)(1076002)(23726003)(6116002)(42882007)(3846002)(81156014)(6486002)(486006)(8666007)(229853002)(81166006)(9686003)(6666003)(8936002)(53936002)(7736002)(59450400001)(386003)(53546011)(6246003)(8676002)(6916009)(72206003)(7416002)(106356001)(478600001)(97736004)(47776003)(66066001)(316002)(5660300001)(93886005)(16586007)(305945005)(2906002)(68736007)(105586002)(25786009)(76506005)(50466002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2897;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2897;23:KqppHJQlaALpC1jry6da0GKUNJVsJ1IMA6JKD7hMO?=
 =?us-ascii?Q?kuLSSl3XSppnbH1epda/2iq4jxVAqLRq4Hr35FRKY1kMGFJko+m1udpbvOys?=
 =?us-ascii?Q?gQfuVaW4qptOZXX28oEDQb4l6ABWeTdzUpZXeTDZwAaypQKuz1Dk9nCRh1bA?=
 =?us-ascii?Q?4rFcBeGnUBZkr70LIQVFj3dvOx+ZoqVXnWkC+KvmeviiTqOj9Lb7rq06lVq+?=
 =?us-ascii?Q?9IYZ8Ay+sWL3fg2EiCkini9Zcc9I/DSqU9E5d0BXIikmpLVe2JW95oOMMBCB?=
 =?us-ascii?Q?Hknyvi7FrdjTF3cYA5mimQGeTJaej/yelzb4OfKUC7NQRLZ28rPNoeNMFXRT?=
 =?us-ascii?Q?Jb7ZzZ7SdVi0qdxCoUDCuiVqjmhchVALCvhx9f6A02kHQjNQY/X+lzUfhiga?=
 =?us-ascii?Q?Y75n12fmJTc5PE9a9klpDE3BJjRI9k9kHP+J9BuTY84cJN9QQqgnZsYKfyj5?=
 =?us-ascii?Q?BIqGdDfTw+I76HvC995PoBM6bEby1UiLk2C4uo0LMBSz8rdXswAkQ2rqikLR?=
 =?us-ascii?Q?nUhwCzdaQPrVPAEiEEegCx/8+Xi3HfOKUt6YPzqzz4QQBD1IY1UxBexT3acG?=
 =?us-ascii?Q?dYWVYID6FBJ97LzHlzzdsWNI7W368rCNZ+PIGoKr4egebofY37LTlyz9Q2iY?=
 =?us-ascii?Q?jGuwK3hczCr5ep2+3dfdP551riAKCId+8IFcwLuOCNTlDX2S8AXavQ+QJiQx?=
 =?us-ascii?Q?uKY96OyBvLbmygDuUPcYloJybsv/7IHxOf3P1ajDb2C9FJ9lnLAakhb+L6Pg?=
 =?us-ascii?Q?VkFR8iw/2c++Hm9fVaiyBNLlZYhguoFWacYi80zzJJW/FkLPkxhg+lc6FI+8?=
 =?us-ascii?Q?2flnrZbHIWbxwZCPHFWJ5mryWplGCGvYCFIWyB+T9Gq3JvsGoOoIGUWE1cgp?=
 =?us-ascii?Q?tFsCwQgAmO3DdgpKgK3tZO3Ryz9LLDl9F93PBstgyA6pFqdkrwwf2H8u2qh2?=
 =?us-ascii?Q?EKI6tl7mP6yJrFVMf9JHuFlokCx3pfwW/S4lTRVlBvUzCnNXHBcMwesuRZdP?=
 =?us-ascii?Q?7DApw4A9/mgVKs8sjXXsKhfBFyvQCgOQBDbcyraHIjKUH8FjQWsq8TTmrk2P?=
 =?us-ascii?Q?l2hynTtbZTxIBuYIn1sQasR4pgI6ATxeDrPuT1iZ3W0/esghyGZ/6b6EObCd?=
 =?us-ascii?Q?IRZB6r/6febPuX1CIOAgRfezxaD+xp0FfgefjRV6jq9x1wIL404fEpJ8N/Oy?=
 =?us-ascii?Q?0hRzukRlorV1eoUUzzvS1rw0I44oN+A6PyLLPH3XmXGH3bA3tSnmTgNHRniF?=
 =?us-ascii?Q?BLAoMrL/ZPyQZbXRA9TV7fZlZT7/3VqeczpMH/xw5186p76oy0Bsz9qMeDLr?=
 =?us-ascii?Q?H/i47q3HSaNedYt9CE/+eNYRNhceybJz1LzsFWLK6/bEuQQ14d1GfXm7K0Bx?=
 =?us-ascii?Q?fe0OPyt7cafZKMZ21Ybq2DCw0Z1+0NYsGGH32B8JnhMxTxiOyzzHzLJQ3TmY?=
 =?us-ascii?Q?v4ilejCY2y0raBbzGcUqJXB1U54V/4=3D?=
X-Microsoft-Antispam-Message-Info: z2WGEhzSKIKhdrw341YpGb2C7cd0LjjAWgd6LE4PdRCX6hp4F314wHLCmnkfWdQEsHOAgn2kJxoh2RwCnJUNr4/G7PSBkNSHS4A6bomoHkE+7L9lwemIOUIbg/Dwv+8n/iytgvUzDerVHTPdl4jq6ZprG/mjKs/uUHmrdXZCe52K57hrZOBfiUpZkBU1AN4b
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;6:EepASgn4E5ESdBc6cc5TP2cs/CIOyGspfRMSwfogrAuf/E1aFWCnN3CgRte2trgkaJ8UvmW4+VCwmmH4Vu0EDNxxN20ciRMeHSU5otRkyhTCbc8aa0xNLFB+MYrtUAGAV/PgUf4tw19iDjbDRwqH87kRpsXw7OCbJt9dQP4QaxFS1/wg/RAbVQaM4JCNIiZtKyRHeZJhOMXSFd04BuW9M77KH9qznv2nTmeG3R71wgVnSHry+sg11tBSiNhRvDr8SvHI/ZmoeUZgYxkhJPttnMN8SHG34EYrecUkbB9fhVS/hdIDzk1yTljzl5acrqWcliw8C1ZSINcR6dvLRbWopa+9n3ANEwL2a5eI+Ijy+snkJw01WLw1WSx3wdpx84iAzKnoqVi8m/pNXoQKNNIntsxf4B3IPRPMLw1EiFfvjQ9mlQ3YRgei8UGuDojvCD0S2k2gZCJmZsm622knstcXww==;5:3NNCebpHFqeFOr7VxPJtOWiUtVQqciHfH4QEL3kDFkMZHkh/kE/A/u4GOaAeRhxB8r0xjx8klacgYBiapgFaykMw/6xBxCH77Dva405kzlOx1WtWJChpgZYMiGAoGwY82x4zq9B1PIgaz1IIVNXergGdY91tUdA/gv303R8WJ4Q=;24:jKR8MvssxY2fo6bsX8isJOSc/P3UNWp7m8lmrqkn3KDuPutexRVLmrYD2tJouPW0b4WCYKUY38Mm8MRSsHGcNrCm01c+c6BX2EyU1ULOhGg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2897;7:hg3S9AFC42c5+BoM6Jn4SfM21b+SoPVB0VVpbKcGyNHd01qnykiJ49SD6WSSbatl/TQezOApk/kWtyHl8VwFe4HhvKThh3jVeKM2qCNekDJe796NY+VpGyItqlgN6qrkkvsFBMe65igLrng55GH3bOuO2ceNv9vq/0LqLIRioxVHW/txns3kRw0FA3C2WCrE3h4XhI0UhtxhMl3L2+aFIoCkSP8rfm+Ztq88PiWPr2QRkDvrxkFf+Y5fQUW79y/z
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 16:53:20.4908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de094ac-e444-4896-66b0-08d59a4c9326
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2897
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 12:58:46AM +0900, Tetsuo Handa wrote:
> Yury Norov wrote:
> > Hi Tetsuo,
> > 
> > Thanks for the patch.
> > 
> > On Wed, Apr 04, 2018 at 09:21:43PM +0900, Tetsuo Handa wrote:
> > > Yury, are you OK with this patch?
> > > 
> > > 
> > > >From 7f21827cdfe9780b4949b22bcd19efa721b463d2 Mon Sep 17 00:00:00 2001
> > > From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > Date: Wed, 4 Apr 2018 21:12:10 +0900
> > > Subject: [PATCH] lib/bitmap: Rewrite __bitmap_parselist().
> > > 
> > > syzbot is catching stalls at __bitmap_parselist() [1]. The trigger is
> > > 
> > >   unsigned long v = 0;
> > >   bitmap_parselist("7:,", &v, BITS_PER_LONG);
> > 
> > Could you add this case to the test_bitmap_parselist()?
> > 
> > > which results in hitting infinite loop at
> > > 
> > >   while (a <= b) {
> > >     off = min(b - a + 1, used_size);
> > >     bitmap_set(maskp, a, off);
> > >     a += group_size;
> > >   }
> > > 
> > > due to used_size == group_size == 0.
> > > 
> > > Current code is difficult to read due to too many flag variables.
> > > Let's rewrite it.
> > 
> > I also don't like current implementation of bitmap_parselist(), but
> > discussion on new code  may take some time. Can you submit minimal
> > fix in separated patch to let people discuss your new implementation
> > without rush?
> 
> OK. Then you can write the patch. You know current code better than I.

Done.
 
> > > @@ -485,6 +485,58 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
> > >  }
> > >  EXPORT_SYMBOL(bitmap_print_to_pagebuf);
> > >  
> > > +static bool get_uint(const char **buf, unsigned int *res)
> > > +{
> > > +	const char *p = *buf;
> > > +
> > > +	if (!isdigit(*p))
> > > +		return false;
> > > +	*res = simple_strtoul(p, (char **) buf, 10);
> > 
> > In comment to simple_strtoul(): "This function is obsolete. Please
> > use kstrtoul instead."
> 
> I intentionally choose simple_strtoul() because next delimiter (e.g. '-')
> starts at returned address. kstrtoul() fails if next letter starts.

OK, but then it should be explained in comment, I think.
 
> > > +	return p < *buf;
> 
> I think I should limit to "0 <= *res <= INT_MAX" range in order to avoid
> overflow at start += group_size.
> 
> > > +}
> > > +
> > > +static int __bitmap_parse_one_chunk(const char *buf, unsigned long *maskp,
> > > +				    const unsigned int nmaskbits)
> > > +{
> > > +	unsigned int start;
> > > +	unsigned int end;
> > > +	unsigned int group_size;
> > > +	unsigned int used_size;
> > > +
> > > +	while (*buf && isspace(*buf))
> > > +		buf++;
> > > +	if (!get_uint(&buf, &start))
> > > +		return -EINVAL;
> > > +	if (*buf == '-') {
> > > +		buf++;
> > > +		if (!get_uint(&buf, &end) || start > end)
> > > +			return -EINVAL;
> > > +		if (*buf == ':') {
> > > +			buf++;
> > > +			if (!get_uint(&buf, &used_size) || *buf++ != '/' ||
> > > +			    !get_uint(&buf, &group_size) ||
> > > +			    used_size > group_size)
> > > +				return -EINVAL;
> > 
> > So this is still not safe against "1-10:0/0", or I miss something?
> > (This is another testcase we should add to test_bitmap.c)
> 
> Indeed. We need to make more testcases.
> 
> > > +	while (buflen && !err) {
> > > +		char *cp;
> > > +		char tmpbuf[256];
> > > +		unsigned int size = min(buflen,
> > > +					(unsigned int) sizeof(tmpbuf) - 1);
> > > +
> > > +		if (!is_user)
> > > +			memcpy(tmpbuf, buf, size);
> > > +		else if (copy_from_user(tmpbuf, (const char __user __force *)
> > > +					buf, size))
> > > +			return -EFAULT;
> > 
> > This is not safe against this:
> > "[250 whitespaces] 567-890:123/456"
> 
> Do we need to accept such insane entry?
 
This is how current implementation works - no limit on number of whitespaces
before and after the cunk. It's userspace interface, and we should be careful
adding new limitations. God forbid us break userspace. :-)

It looks insane, but this kind of things is quite possible if input string
is the result of heavy scripting.
 
> > And it will be Schlemiel the painter's-styled algorithm for input like:
> > "1,2,3,4, ... ,98,99,100". 
> > 
> > I think we need something like __bitmap_parse_get_chunk() to copy
> > coma-separated substrings.
